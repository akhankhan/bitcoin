// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/customwidgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/profile_screen/profile_screen_provider.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({super.key, required this.valueModel});
  final ProfileScreenProvider valueModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            hintText: 'Old password',
            controller: valueModel.email,
            readOnly: true,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            hintText: 'Old password',
            controller: valueModel.password,
          ),
          SizedBox(height: 15.h),
          // CustomTextField(
          //   hintText: 'New password',
          // ),
          // SizedBox(height: 15.h),
          // CustomTextField(
          //   hintText: 'New password again',
          // ),
          SizedBox(height: 25.h),
          CustomButton(
            onPress: () {
              valueModel.resetPassword(
                valueModel.email.text,
                valueModel.password.text,
              );

              SnackBar(content: Text("Check your email link has been send"));
            },
            text: 'Continue',
            width: 300,
          ),
          SizedBox(height: 15.h),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 16, decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }
}
