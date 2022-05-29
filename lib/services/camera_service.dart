import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraService {
  factory CameraService() => _cameraService;
  static final CameraService _cameraService = CameraService._();

  CameraService._();

  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  InputImageRotation? _cameraRotation;
  InputImageRotation? get cameraRotation => _cameraRotation;

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future initializeCamera() async {
    if (cameraController != null) {
      return;
    }
    CameraDescription description = await getCameraDescription();
    await _setupCameraController(description: description);
    _cameraRotation = rotationIntToImageRotation(description.sensorOrientation);
  }

  Future<CameraDescription> getCameraDescription() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
        camera.lensDirection == CameraLensDirection.front);
  }

  Future _setupCameraController(
      {required CameraDescription description}) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
  }

  InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Future<XFile?> takePicture() async {
    assert(_cameraController != null, 'Camera controller not initialized');
    await _cameraController?.stopImageStream();
    XFile? xFile = await _cameraController?.takePicture();
    _imagePath = xFile?.path;
    return xFile;
  }

  Size getImageSize() {
    assert(_cameraController != null, 'Camera controller not initialized');
    assert(
        _cameraController?.value.previewSize != null, 'Preview size is null');
    return Size(_cameraController!.value.previewSize!.width,
        _cameraController!.value.previewSize!.width);
  }

  Future dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}
