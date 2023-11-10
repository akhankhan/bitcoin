// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/screens/authentications/sign_up_screen/sign_up_screen.dart';
import 'package:bitcoinapp/screens/pinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../authentications/signin_screen/signinscreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/skyvalletlogo.png',
              height: 150.h,
              width: 150.w,
            ),
            SizedBox(height: 20.h),
            Image.asset(
              'assets/images/undraw_mobile_ux_re_59hr 1.png',
              height: 190,
              width: 190,
            ),
            SizedBox(height: 50.h),
            Text(
              'Pay Bills and \n more',
              style: TextStyle(
                  color: const Color.fromARGB(255, 11, 107, 151), fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              text: 'Create Account',
              width: 300,
              fontColor: Colors.white,
              color: const Color.fromARGB(255, 85, 166, 233),
            ),
            SizedBox(height: 20.h),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 25, decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
