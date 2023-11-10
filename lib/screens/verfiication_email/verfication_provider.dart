import 'dart:async';
import 'dart:developer';

import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationEmailProvider with ChangeNotifier {
  VerificationEmailProvider(context) {
    // user = auth.currentUser;
    // user!.sendEmailVerification();

    // timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   checkEmailVerified();
    // });
    if (FirebaseAuth.instance.currentUser != null) {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    }
    if (!isEmailVerified) {
      // checkEmailVerified(context);
      // _emailVerificationService.checkEmailVerified();

      timer = Timer.periodic(
          const Duration(seconds: 2), (_) => checkEmailVerified(context));
    }
  }
  

  Timer? timer;
  final auth = FirebaseAuth.instance;
  User? user;
  bool isEmailVerified = false;

  void checkEmailVerified(BuildContext context) async {
    user = auth.currentUser;
    await user!.reload();
    log("checking user...${user!.emailVerified}");
    if (user!.emailVerified) {
      final CollectionReference firestore =
          FirebaseFirestore.instance.collection('users');
      var id = FirebaseAuth.instance.currentUser!.uid;
      firestore.doc(id).update({
        "isEmailVerfied": true,
      });
      timer!.cancel();
      log("email is verified...");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  Future<void> resendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
