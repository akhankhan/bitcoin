import 'dart:io';

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/screens/profile_screen/back_camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'font_camera_screen.dart';
import 'profile_screen_provider.dart';

class DocumentVerfication extends StatefulWidget {
  const DocumentVerfication({super.key, required this.valueModel});
  final ProfileScreenProvider valueModel;

  @override
  State<DocumentVerfication> createState() => _DocumentVerficationState();
}

class _DocumentVerficationState extends State<DocumentVerfication> {
  // late CameraController fontController;
  // late CameraController backController;

  // String? imagePath;

  // void captureAndSaveImage() async {
  //   if (controller.value.isInitialized) {
  //     XFile? imageFile = await controller.takePicture();
  //     setState(() {
  //       imagePath = imageFile.path;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // availableCameras().then((cameras) {
    //   controller = CameraController(cameras[0], ResolutionPreset.medium);
    //   controller.initialize().then((_) {
    //     if (!mounted) {
    //       return;
    //     }
    //     setState(() {});
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {
    //   return Container();
    // }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: widget.valueModel.isDocumentSend,
          builder: (context, isDocSend, child) {
            return isDocSend == true
                ? const Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Your Document has been Progress.',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'You will notify after document has been verifed...',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Take a photo of front and back of your ID card',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          'Your data will be kept safe and will not be shared with your ID Card.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Front of ID',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: widget.valueModel.frontimagePath!,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              await widget.valueModel
                                  .selecFontImageFromCamera();

                              // final imagePath =
                              //     widget.valueModel.frontimagePath;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => FontCameraScreen(
                              //       valueModel: widget.valueModel,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 0.1,
                                    color: Colors.grey,
                                    offset: Offset(0.1, 0.5),
                                  )
                                ],
                              ),
                              child: widget.valueModel.frontimagePath!.value
                                      .isNotEmpty
                                  ? Image.file(
                                      File(widget
                                          .valueModel.frontimagePath!.value),
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text(
                                        'Click here',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Back of ID',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: widget.valueModel.backimagePath!,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () async {
                              widget.valueModel.selecBackImageFromCamera();

                              // final imagePath = widget.valueModel.backimagePath;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BackCameraScreen(
                              //       valueModel: widget.valueModel,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 0.1,
                                    color: Colors.grey,
                                    offset: Offset(0.1, 0.5),
                                  )
                                ],
                              ),
                              child: widget.valueModel.backimagePath!.value
                                      .isNotEmpty
                                  ? Image.file(
                                      File(widget
                                          .valueModel.backimagePath!.value),
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text(
                                        'Click here',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),

                      ValueListenableBuilder(
                          valueListenable: widget.valueModel.loading!,
                          builder: (context, loading, child) {
                            return loading == true
                                ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: CustomButton(
                                      onPress: () {
                                        widget.valueModel.submitDocument();
                                      },
                                      text: 'Submit',
                                      color: Colors.black,
                                      fontColor: Colors.white,
                                    ),
                                  );
                          })

                      // Expanded(
                      //   child: imagePath != null
                      //       ? Image.file(File(imagePath!))
                      //       : const CameraScreen(),
                      // ),
                      // ElevatedButton(
                      //   onPressed: captureAndSaveImage,
                      //   child: const Text('Capture Image'),
                      // ),
                    ],
                  );
          }),
    ));
  }
}
