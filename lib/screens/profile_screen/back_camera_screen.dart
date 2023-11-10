import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'profile_screen_provider.dart';

class BackCameraScreen extends StatefulWidget {
  const BackCameraScreen({Key? key, required this.valueModel})
      : super(key: key);
  final ProfileScreenProvider valueModel;

  @override
  State<BackCameraScreen> createState() => _BackFontCameraScreenState();
}

class _BackFontCameraScreenState extends State<BackCameraScreen> {
  late Future<void> _initializeControllerFuture;
  late CameraController? controller;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (controller == null || !controller!.value.isInitialized) {
            return Container(
              width: double.infinity,
              color: Colors.green,
            ); // Or any placeholder widget you prefer
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 120,
                    child: CameraPreview(controller!),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 0,
                    child: SizedBox(
                      height: 60,
                      child: CustomButton(
                        onPress: () async {
                          await widget.valueModel
                              .backcaptureAndSaveImage(controller!);
                          Navigator.pop(context);
                        },
                        text: 'Capture',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while initializing the camera
        }
      },
    );
  }
}
