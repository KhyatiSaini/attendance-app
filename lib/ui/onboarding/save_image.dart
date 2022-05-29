import 'dart:io';
import 'dart:math';

import 'package:attendance_tracker/models/user_image.dart';
import 'package:attendance_tracker/services/camera_service.dart';
import 'package:attendance_tracker/services/database_helper.dart';
import 'package:attendance_tracker/services/face_detector_service.dart';
import 'package:attendance_tracker/services/ml_service.dart';
import 'package:attendance_tracker/ui/pages/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../utils/colors/colors.dart';
import '../../utils/face_painter.dart';
import '../../utils/snackbar.dart';

class SaveImagePage extends StatefulWidget {
  const SaveImagePage({Key? key}) : super(key: key);

  @override
  State<SaveImagePage> createState() => _SaveImagePageState();
}

class _SaveImagePageState extends State<SaveImagePage> {
  final double mirror = pi;

  Size? imageSize;
  String? imagePath;
  Face? faceDetected;

  bool saving = false;
  bool initializing = false;
  bool pictureTaken = false;
  bool detectingFaces = false;

  FaceDetectorService faceDetectorService = FaceDetectorService();
  CameraService cameraService = CameraService();
  MLService mlService = MLService();

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  void dispose() {
    cameraService.dispose();
    mlService.dispose();
    faceDetectorService.dispose();
    super.dispose();
  }

  Future start() async {
    setState(() {
      initializing = true;
    });

    await cameraService.initializeCamera();

    setState(() {
      initializing = false;
    });

    frameFaces();
  }

  Future<bool> onShot() async {
    if (faceDetected == null) {
      showSnackBar(context, 'No face detected');
      return false;
    } else {
      saving = true;
      await Future.delayed(const Duration(milliseconds: 500));
      await cameraService.cameraController?.stopImageStream();
      await Future.delayed(const Duration(milliseconds: 200));
      XFile? file = await cameraService.takePicture();
      imagePath = file?.path;

      setState(() {
        pictureTaken = true;
      });

      return true;
    }
  }

  void frameFaces() {
    imageSize = cameraService.getImageSize();

    cameraService.cameraController!.startImageStream((image) async {
      if (cameraService.cameraController != null) {
        if (detectingFaces) {
          return;
        }

        detectingFaces = true;

        try {
          await faceDetectorService.detectFaceFromImage(image);
          if (faceDetectorService.faces.isNotEmpty) {
            if (saving) {
              faceDetected = faceDetectorService.faces.first;
              mlService.setCurrentPrediction(image, faceDetected);
              setState(() {
                saving = false;
              });
            }
          } else {
            setState(() {
              faceDetected = null;
            });
          }

          detectingFaces = false;
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
          detectingFaces = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.orangeLight.shade100,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: const Text(
                  'Please click your photograph and upload for face recognition and detection.',
                  style: TextStyle(
                    color: CustomColors.orangeColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColors.orangeLight.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: (initializing)
                      ? Center(
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator(
                                  color: CustomColors.orangeColor,
                                )
                              : const CupertinoActivityIndicator(
                                  color: CustomColors.orangeColor,
                                ),
                        )
                      : (!initializing && pictureTaken)
                          ? Container(
                              width: double.infinity,
                              height: 300,
                              padding: const EdgeInsets.all(8),
                              child: Transform(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.file(File(imagePath!)),
                                ),
                                transform: Matrix4.rotationY(mirror),
                              ),
                            )
                          : (!initializing && !pictureTaken)
                              ? Transform.scale(
                                  scale: 1.0,
                                  child: AspectRatio(
                                    aspectRatio:
                                        MediaQuery.of(context).size.aspectRatio,
                                    child: OverflowBox(
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              cameraService.cameraController!
                                                  .value.aspectRatio,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              CameraPreview(cameraService
                                                  .cameraController!),
                                              CustomPaint(
                                                painter: FacePainter(
                                                  face: faceDetected,
                                                  imageSize: imageSize!,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    onShot();
                    DatabaseHelper _databaseHelper = DatabaseHelper();
                    List predictedData = mlService.predictedData;
                    UserImageModel userToSave = UserImageModel(
                      email: 'khyati',
                      imageModel: predictedData,
                    );
                    await _databaseHelper.insert(userToSave);
                    mlService.setPredictedData([]);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  },
                  elevation: 0,
                  minWidth: double.infinity,
                  height: 48,
                  color: CustomColors.orangeColor,
                  splashColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: CustomColors.orangeLight.shade50,
                    ),
                  ),
                ),
              ),
              // AuthActionButton(
              //   onPressed: onShot,
              //   isLogin: false,
              //   reload: () => Navigator.of(context).pop(),
              //   email: 'khyati',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
