// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:developer';

import 'package:bitcoinapp/customwidgets/coinsbottomsheet.dart';
import 'package:bitcoinapp/screens/authentications/signin_screen/signinscreen.dart';
import 'package:bitcoinapp/screens/chat_screen/chat_screen.dart';
import 'package:bitcoinapp/screens/profile_screen/profile_detail.dart';
import 'package:bitcoinapp/screens/profile_screen/securityscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'document_verfication.dart';
import 'profile_screen_provider.dart';

class PRofileScreen extends StatelessWidget {
  const PRofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => ProfileScreenProvider(),
            child: Consumer<ProfileScreenProvider>(
                builder: (context, valueModel, child) {
              return Container(
                //color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //   bottomLeft: Radius.elliptical(30, 8),
                            //   bottomRight: Radius.elliptical(30, 8),
                            // ),
                            color: Colors.teal,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                valueModel.isLoading == true
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          valueModel.getImage();
                                        },
                                        child: valueModel.imageFile != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  valueModel.imageFile!,
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              )
                                            : valueModel.userData[0].pic !=
                                                        null &&
                                                    valueModel.userData[0].pic!
                                                        .isNotEmpty
                                                ? Image.network(
                                                    valueModel.userData[0].pic
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    width: 100,
                                                    height: 100,
                                                  )
                                                : Image.asset(
                                                    'assets/icons/Profile.png',
                                                    color: Colors.white,
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                      ),
                                SizedBox(height: 13.h),
                                Text(
                                  '${valueModel.userData[0].name} ${valueModel.userData[0].lastName}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(height: 13.h),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            //color: Colors.white,
                            width: 500.w,
                            padding:
                                EdgeInsets.only(top: 234, left: 25, right: 25),
                            child: Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Level 0',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.teal),
                                    ),
                                    SizedBox(width: 100.w),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'increase Limits',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.teal,
                                              decoration:
                                                  TextDecoration.underline),
                                        )),
                                    Icon(
                                      Icons.call_missed_outgoing_sharp,
                                      color: Colors.teal,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CustomRow(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileDetailScreen(
                                        userModel: valueModel.userData,
                                        valueModel: valueModel,
                                      ),
                                    ),
                                  );
                                },
                                image: 'assets/icons/Profile.png',
                                text: 'Profile Details',
                              ),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              CustomRow(
                                  //  onTap: () => showClearHistoryConfirmationDialog(context),
                                  image:
                                      'assets/images/credit-card-2-icon-7.png',
                                  text: 'Payment Details'),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              CustomRow(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecurityScreen(
                                                  valueModel: valueModel,
                                                )));
                                  },
                                  image: 'assets/icons/Settingicon.png',
                                  text: 'Security'),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              CustomRow(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DocumentVerfication(
                                                  valueModel: valueModel,
                                                )));
                                  },
                                  image: 'assets/icons/Settingicon.png',
                                  text: 'Document Verfication'),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              CustomRow(
                                  image: 'assets/images/contactsupport.png',
                                  text: 'Contact Support'),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              CustomRow(
                                image: 'assets/images/delete.png',
                                text: 'Delete Account',
                              ),
                              SizedBox(height: 10.h),
                              Divider(
                                color: Color(0xff3938605e),
                                thickness: 1,
                                indent: 20,
                              ),
                              SizedBox(height: 10.h),
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()));
                                  },
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ));
  }
}

class GridItem extends StatelessWidget {
  final IconData image;
  final String text;

  const GridItem({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white, // Example color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(image),
              SizedBox(height: 5.h),
              Text(text),
            ],
          ), // Replace with your image
        ),
      ],
    );
  }
}

class CustomRow extends StatelessWidget {
  final String image;
  final String text;
  final Function()? onTap;
  const CustomRow({
    required this.image,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 24,
                width: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  //  'Language',
                  text,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.teal,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto-Medium'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
