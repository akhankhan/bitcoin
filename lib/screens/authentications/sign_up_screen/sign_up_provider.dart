import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/user.dart';
import '../../verfiication_email/verfication_email_screen.dart';

class SignUpProvider with ChangeNotifier {
  String password = "";

  UserModel userModel = UserModel();

  Future<void> registerUser(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email.toString(), password: password);

      // Send email verification
      storeUserData(userCredential);
      User? user = userCredential.user;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const VerficationEmailScreen()));
      await user!.sendEmailVerification();
    } catch (e) {
      log("checkkkkkkk001:${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  storeUserData(userCredential) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = userCredential.user.uid;
    userModel.id = uid;
    userModel.isEmailVerfied = false;
    userModel.pic = '';
    await firestore.collection('users').doc(uid).set(userModel.toJson());
  }
}
