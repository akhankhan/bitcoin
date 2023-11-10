import 'dart:developer';

import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../verfiication_email/verfication_email_screen.dart';

class SignInScreenProvider with ChangeNotifier {
  // SignInScreenProvider();
  String email = "";
  String password = "";

  signInWithEmailAndPassword(context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseAuth.instance.signOut;
      }
      log("checkkk emial $email $password");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      bool isEmailVerify = await checkEmailIsVerified(user!.uid);
      if (isEmailVerify == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const VerficationEmailScreen()));
      }

      log("cccccccccccccc");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log("check1");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User not found"), // Corrected message
        ));
      } else if (e.code == 'wrong-password') {
        log("check2");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong password"), // Corrected message
        ));
      } else {
        // Handle other authentication exceptions if needed
      }
      return false;
    } catch (e) {
      log("check3");
      log('SIGNIN: ${e.toString()}');
      return false;
    }
  }
}

Future<bool> checkEmailIsVerified(String uid) async {
  bool isVerifyed = false;

  try {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      isVerifyed = userDoc["isEmailVerfied"];
    }

    if (isVerifyed == true) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}

// Future<void> signInWithEmailAndPassword(context) async {
//   try {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     // bool isEmailVerify = await isEmailVerified();
//     // if (isEmailVerify) {
//     //   Navigator.pushReplacement(
//     //       context, MaterialPageRoute(builder: (context) => Dashboard()));
//     // } else {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(
//     //       content: Text("Please verify your email address."),
//     //     ),
//     //   );
//     // }
//     notifyListeners();
//   } catch(eeo)
// }

Future<bool> isEmailVerified() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user!.emailVerified == true) {
    return true;
  } else {
    return false;
  }
}
