// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/customwidgets/customtextfield.dart';
import 'package:bitcoinapp/screens/authentications/recover_password.dart';
import 'package:bitcoinapp/screens/authentications/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import 'signin_screen_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Sign in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: ChangeNotifierProvider(
                create: (context) => SignInScreenProvider(),
                child: Consumer<SignInScreenProvider>(
                    builder: (context, valueModel, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      CustomTextField(
                        onChanged: (value) {
                          valueModel.email = value;
                        },
                        hintText: 'Email',
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        onChanged: (value) {
                          valueModel.password = value;
                        },
                        hintText: 'Password',
                      ),
                      SizedBox(height: 30.h),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecoverPassword()));
                          },
                          child: Text(
                            'Recover Password?',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          )),
                      SizedBox(height: 50.h),
                      CustomButton(
                        onPress: () {
                          log("click signin");
                          valueModel.signInWithEmailAndPassword(context);
                        },
                        text: 'Continue',
                        width: 300,
                      ),
                      SizedBox(height: 30.h),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          child: Text(
                            'Create Account?',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  );
                }),
              ),
            ),
          ),
        ));
  }
}
