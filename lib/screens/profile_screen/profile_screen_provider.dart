import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bitcoinapp/model/user.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenProvider with ChangeNotifier {
  List<UserModel> userData = [];
  bool isLoading = false;
  File? imageFile;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  String pin = '';
  String confirmPin = '';
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  bool isShowConfirmScreen = false;

  ValueNotifier<bool> isDocumentSend = ValueNotifier<bool>(false);

  final formKey = GlobalKey<FormState>();

  TextEditingController pinCode = TextEditingController();
  TextEditingController pinContorller = TextEditingController();
  TextEditingController pinConfirmContorller = TextEditingController();

  ProfileScreenProvider() {
    getUserData();
  }

  Future<void> getUserData() async {
    isLoading = true;
    late StreamSubscription<QuerySnapshot> subscription;
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    //FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");

    subscription = collectionReference
        .where('id', isEqualTo: uid) // Add this filter for the specific UID
        .snapshots()
        .listen((snapshot) {
      userData.clear(); // Clear the existing list

      for (var document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        userData.add(UserModel(
          id: document.id,
          name: data['name'],
          lastName: data['lastName'],
          email: data['email'],
          phoneNumber: data['phoneNumber'],
          pic: data['imageUrl'],
          isDocumentSend: data['isDocumetSend'],
        ));
        log("check data:$uid");
        isDocumentSend.value = data['isDocumetSend'] ?? false;
      }
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> updateProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      "email": email.text,
      "name": firstName.text,
      "lastName": lastName.text,
      "phoneNumber": phoneNumber.text,
    });
  }

  getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      notifyListeners();
      String imagePath = image.path;
      String imageName =
          'userProfile.jpg'; // You can use a unique name for each image
      await uploadImageToFirestore(imagePath, imageName);
    }
  }

  Future<void> uploadImageToFirestore(
      String imagePath, String imageName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child(uid).child(imageName);

    UploadTask uploadTask = storageReference.putFile(File(imagePath));

    TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
      // The image was successfully uploaded to Firebase Storage.
      String downloadUrl = await storageReference.getDownloadURL();
      await storeImage(downloadUrl);
      print('Image uploaded to Firebase Storage. Download URL: $downloadUrl');
    } else {
      print('Failed to upload image.');
    }
  }

  Future<void> storeImage(String imageUrl) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Update the 'imageUrl' field for the user in Firestore
    await users.doc(uid).update({
      'imageUrl': imageUrl,
    });
  }

  void togglePassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
    log("check value:$isShowPassword");
  }

  void toggleConfrimPassword() {
    isShowConfirmPassword = !isShowConfirmPassword;

    notifyListeners();
    log("check value:$isShowPassword");
  }

  void toggleShowConfirmScreen() {
    isShowConfirmScreen = true;
//    pinContorller.text = pinCode.text;
    notifyListeners();
  }

  Future<void> savePin() async {
    //! form valuediato for both password
    log("check1 ${pinContorller.text}");
    log("check2 ${pinConfirmContorller.text}  ");

    if (pinContorller.text == pinConfirmContorller.text) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'pinCode': pinContorller.text,
        'isPinCode': true,
      });
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // The reset email has been sent to the user's email address.
      // You've already sent the password reset email.
      // Now, you need to update the user's password with the new one.

      // Update the user's password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: newPassword,
      );

      // Optionally, sign the user out after resetting their password
      await FirebaseAuth.instance.signOut();

      // Provide feedback to the user that their password has been successfully reset.
    } catch (e) {
      // Handle errors, such as invalid email or user not found.
      // Provide appropriate error messages to the user.
    }
  }

  late CameraController _controller;
  late CameraController _controller2;

  //String? imagePath;
  ValueNotifier<String>? frontimagePath = ValueNotifier<String>('');
  ValueNotifier<String>? backimagePath = ValueNotifier<String>('');

  String frontImage = '';
  String backImage = '';

  CameraController get frontcontroller => _controller;
  CameraController get backcontroller => _controller2;
  ValueNotifier<bool>? loading = ValueNotifier<bool>(false);

  Future<void> frontcaptureAndSaveImage(CameraController con) async {
    if (con.value.isInitialized) {
      // Store the original flash mode
      final FlashMode originalFlashMode = con.value.flashMode;

      // Disable the flashlight during image capture
      con.setFlashMode(FlashMode.off);

      final XFile imageFile = await con.takePicture();
      frontImage = imageFile.path;

      // Restore the original flash mode
      con.setFlashMode(originalFlashMode);

      frontimagePath!.value = imageFile.path;
      con.dispose();
      notifyListeners();
    }
  }

  selecFontImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    if (file != null) {
      frontimagePath!.value = file.path;
      frontImage = file.path;

      notifyListeners();

      return file.path;
    } else {
      return '';
    }
  }

  selecBackImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      backimagePath!.value = file.path;
      backImage = file.path;

      notifyListeners();

      return file.path;
    } else {
      return '';
    }
  }

  Future<void> backcaptureAndSaveImage(CameraController con) async {
    if (con.value.isInitialized) {
      // Store the original flash mode
      final FlashMode originalFlashMode = con.value.flashMode;

      // Disable the flashlight during image capture
      con.setFlashMode(FlashMode.off);

      final XFile imageFile = await con.takePicture();
      backImage = imageFile.path;

      // Restore the original flash mode
      con.setFlashMode(originalFlashMode);

      backimagePath!.value = imageFile.path;
      con.dispose();
      notifyListeners();
    }
  }

  Future<void> submitDocument() async {
    loading!.value = true;
    notifyListeners();
    String frontDocImage = 'frontDocumentImage.jpg';
    String backDocImage = 'backDocumentimage.jpg';
    await uploadFrontDocumentImage(frontImage, frontDocImage);
    await uploadBackDocumentImage(backImage, backDocImage);
    loading!.value = false;
    getUserData();
    notifyListeners();
  }

  Future<void> uploadFrontDocumentImage(
      String fontImagePath, String fontImageName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child(uid).child(fontImageName);

    UploadTask uploadTask = storageReference.putFile(File(fontImagePath));

    TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
      // The image was successfully uploaded to Firebase Storage.
      String downloadUrl = await storageReference.getDownloadURL();
      await storeFontDocImage(downloadUrl);
      print('Image uploaded to Firebase Storage. Download URL: $downloadUrl');
    } else {
      print('Failed to upload image.');
    }
  }

  Future<void> uploadBackDocumentImage(
      String backImagePath, String backImageName) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child(uid).child(backImageName);

    UploadTask uploadTask = storageReference.putFile(File(backImagePath));

    TaskSnapshot snapshot = await uploadTask;
    if (snapshot.state == TaskState.success) {
      // The image was successfully uploaded to Firebase Storage.
      String downloadUrl = await storageReference.getDownloadURL();
      await storeBackDocImage(downloadUrl);
      print('Image uploaded to Firebase Storage. Download URL: $downloadUrl');
    } else {
      print('Failed to upload image.');
    }
  }

  Future<void> storeFontDocImage(String imageUrl) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Update the 'imageUrl' field for the user in Firestore
    await users.doc(uid).update({
      'frontDocumentImage': imageUrl,
      'isDocumetSend': true,
      'documentPorgress': 'pending',
    });
  }

  Future<void> storeBackDocImage(String imageUrl) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Update the 'imageUrl' field for the user in Firestore
    await users.doc(uid).update({
      'backDocumentImage': imageUrl,
    });
  }

  Future<void> checkSendDoucment() async {}

  @override
  void dispose() {
    frontcontroller.dispose();
    super.dispose();
  }

// if (image != null) {
//   String imagePath = image.path;
//   String imageName = 'unique_image_name.jpg'; // You can use a unique name for each image
//   uploadImageToFirestore(imagePath, imageName);
// }
}
