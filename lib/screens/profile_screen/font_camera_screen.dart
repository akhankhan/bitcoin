import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_screen_provider.dart';

class FontCameraScreen extends StatefulWidget {
  const FontCameraScreen({Key? key, required this.valueModel})
      : super(key: key);
  final ProfileScreenProvider valueModel;

  @override
  State<FontCameraScreen> createState() => _FontCameraScreenState();
}

class _FontCameraScreenState extends State<FontCameraScreen> {
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
            return Container(); // Or any placeholder widget you prefer
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
                          // await widget.valueModel
                          //     .selectImageFromCamera();
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
