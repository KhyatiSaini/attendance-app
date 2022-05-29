import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:attendance_tracker/models/user_image.dart';
import 'package:attendance_tracker/services/database_helper.dart';
import 'package:attendance_tracker/services/image_converter.dart';
import 'package:image/image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MLService {
  factory MLService() => _mlService;
  static final MLService _mlService = MLService._();
  MLService._();

  Interpreter? _interpreter;
  double threshold = 0.5;

  List _predictedData = [];
  List get predictedData => _predictedData;

  Future initialize() async {
    late Delegate delegate;
    try {
      if (Platform.isAndroid) {
        delegate = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
            isPrecisionLossAllowed: false,
            inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
            inferencePriority1: TfLiteGpuInferencePriority.minLatency,
            inferencePriority2: TfLiteGpuInferencePriority.auto,
            inferencePriority3: TfLiteGpuInferencePriority.auto,
          ),
        );
      } else if (Platform.isIOS) {
        delegate = GpuDelegate(
          options: GpuDelegateOptions(
            allowPrecisionLoss: true,
            waitType: TFLGpuDelegateWaitType.active,
          ),
        );
      }

      InterpreterOptions interpreterOptions = InterpreterOptions()
        ..addDelegate(delegate);
      _interpreter = await Interpreter.fromAsset(
        'mobilefacenet.tflite',
        options: interpreterOptions,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load model');
        print(e);
      }
    }
  }

  void setCurrentPrediction(CameraImage cameraImage, Face? face) {
    if (_interpreter == null) throw Exception('Interpreter is null');
    if (face == null) throw Exception('Face is null');
    List input = _preProcess(cameraImage, face);

    input = input.reshape([1, 112, 112, 3]);
    List output = List.generate(1, (index) => List.filled(192, 0));

    _interpreter?.run(input, output);
    output = output.reshape([192]);

    _predictedData = List.from(output);
  }

  Future<UserImageModel?> predict() async {
    return _searchResult(_predictedData);
  }

  List _preProcess(CameraImage image, Face faceDetected) {
    Image croppedImage = _cropFace(image, faceDetected);
    Image img = copyResizeCropSquare(croppedImage, 112);

    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  Image _cropFace(CameraImage image, Face faceDetected) {
    Image convertedImage = _convertCameraImage(image);
    double x = faceDetected.boundingBox.left - 10.0;
    double y = faceDetected.boundingBox.top - 10.0;
    double w = faceDetected.boundingBox.width + 10.0;
    double h = faceDetected.boundingBox.height + 10.0;
    return copyCrop(
        convertedImage, x.round(), y.round(), w.round(), h.round());
  }

  Image _convertCameraImage(CameraImage image) {
    var img = convertToImage(image);
    var img1 = copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  Future<UserImageModel?> _searchResult(List predictedData) async {
    DatabaseHelper _dbHelper = DatabaseHelper();

    List<UserImageModel> userImageModels = await _dbHelper.queryAllImages();
    double minDist = 999;
    double currDist = 0.0;
    UserImageModel? predictedResult;

    for (UserImageModel u in userImageModels) {
      currDist = _euclideanDistance(u.imageModel, predictedData);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predictedResult = u;
      }
    }
    return predictedResult;
  }

  double _euclideanDistance(List? e1, List? e2) {
    if (e1 == null || e2 == null) throw Exception("Null argument");

    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  void setPredictedData(value) {
    _predictedData = value;
  }

  dispose() {}
}
