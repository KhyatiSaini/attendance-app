import 'package:attendance_tracker/services/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/painting.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectorService {
  factory FaceDetectorService() => _faceDetectorService;
  static final FaceDetectorService _faceDetectorService =
      FaceDetectorService._();
  FaceDetectorService._();

  CameraService cameraService = CameraService();

  late FaceDetector _faceDetector;
  FaceDetector get faceDetector => _faceDetector;

  List<Face> _faces = [];
  List<Face> get faces => _faces;
  bool get faceDetected => _faces.isNotEmpty;

  void initialize() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
  }

  Future detectFaceFromImage(CameraImage image) async {
    InputImageData _firebaseImageMetaData = InputImageData(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation:
          cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
      inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw) ??
          InputImageFormat.nv21,
      planeData: image.planes
          .map(
            (Plane plane) => InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            ),
          )
          .toList(),
    );

    InputImage _firebaseVisionImage = InputImage.fromBytes(bytes: image.planes[0].bytes, inputImageData: _firebaseImageMetaData);
    _faces = await _faceDetector.processImage(_firebaseVisionImage);
  }

  void dispose() {
    _faceDetector.close();
  }
}
