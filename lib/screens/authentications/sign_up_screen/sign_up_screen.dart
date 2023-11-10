// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/customwidgets/customtextfield.dart';
import 'package:bitcoinapp/screens/authentications/signin_screen/signinscreen.dart';
import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../verfiication_email/verfication_email_screen.dart';
import 'sign_up_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            'Create Account',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ChangeNotifierProvider(
            create: (context) => SignUpProvider(),
            child:
                Consumer<SignUpProvider>(builder: (context, valueModel, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomTextField(
                        onChanged: (value) {
                          valueModel.userModel.name = value;
                        },
                        hintText: 'First Name',
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        onChanged: (value) {
                          valueModel.userModel.lastName = value;
                        },
                        hintText: 'Last Name',
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        hintText: 'Email',
                        onChanged: (value) {
                          valueModel.userModel.email = value;
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        hintText: 'Password',
                        onChanged: (value) {
                          valueModel.password = value;
                        },
                      ),
                      SizedBox(height: 15.h),
                      IntlPhoneField(
                        onChanged: (value) {
                          valueModel.userModel.phoneNumber =
                              value.countryCode + value.number;
                        },
                        decoration: InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.grey,
                            ))),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Color(0xFFDBE2E9)),
                      //       color: Color(0XFFDBE2E9).withOpacity(0.3),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: InternationalPhoneNumberInput(
                      //     inputBorder: InputBorder.none,
                      //     onInputChanged: (PhoneNumber number) {
                      //       log("bb: $number");
                      //       valueModel.userModel.phoneNumber =
                      //           number.phoneNumber;
                      //     },
                      //     hintText: 'Phone Number',
                      //     initialValue: PhoneNumber(isoCode: 'US'),
                      //   ),
                      // ),
                      SizedBox(height: 15.h),
                      RichText(
                        text: TextSpan(
                          text: 'By clicking "Continue" you accept the \n',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'terms of use',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: ' and acknowledge the ',
                            ),
                            TextSpan(
                              text: 'privacy policy.',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomButton(
                        onPress: () {
                          log("cc: ${valueModel.userModel.phoneNumber}");
                          valueModel.registerUser(context);
                        },
                        text: 'SignUp',
                        width: 300,
                      ),
                      SizedBox(height: 30.h),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()));
                          },
                          child: Text(
                            'Login to your Account?',
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
