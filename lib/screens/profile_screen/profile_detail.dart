// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/customwidgets/customtextfield.dart';
import 'package:bitcoinapp/screens/authentications/signin_screen/signinscreen.dart';
import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../model/user.dart';
import 'profile_screen_provider.dart';

class ProfileDetailScreen extends StatelessWidget {
  ProfileDetailScreen({
    super.key,
    required this.userModel,
    required this.valueModel,
  });

  List<UserModel> userModel;
  ProfileScreenProvider valueModel;

  @override
  Widget build(BuildContext context) {
    valueModel.firstName.text = userModel[0].name.toString();
    valueModel.lastName.text = userModel[0].lastName.toString();
    valueModel.email.text = userModel[0].email.toString();
    valueModel.phoneNumber.text = userModel[0].phoneNumber.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
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
          'Profile Details',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                CustomTextField(
                  controller: valueModel.firstName,
                  hintText: 'First Name',
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: valueModel.lastName,
                  hintText: 'Last Name',
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: valueModel.email,
                  hintText: 'Email',
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: valueModel.phoneNumber,
                  hintText: 'PhoneNumber',
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Color(0xFFDBE2E9)),
                //       color: Color(0XFFDBE2E9).withOpacity(0.3),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: InternationalPhoneNumberInput(
                //     textFieldController: valueModel.phoneNumber,
                //     inputBorder: InputBorder.none,
                //     onInputChanged: (PhoneNumber number) {
                //       valueModel.phoneNumber = number as TextEditingController;
                //     },
                //     hintText: 'Phone Number',
                //     initialValue: PhoneNumber(isoCode: 'US'),
                //   ),
                // ),
                SizedBox(height: 15.h),
                SizedBox(height: 50.h),
                CustomButton(
                  onPress: () {
                    valueModel.updateProfile();
                    // Navigator.pop(context);
                  },
                  text: 'Update Profile',
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
