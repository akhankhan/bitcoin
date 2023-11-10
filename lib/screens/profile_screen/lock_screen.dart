import 'dart:developer';

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:bitcoinapp/screens/profile_screen/profile_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatelessWidget {
  const LockScreen(
      {super.key,
      required this.pinCode,
      required this.name,
      required this.email});
  final String pinCode;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ChangeNotifierProvider(
        create: (_) => ProfileScreenProvider(),
        child: Consumer<ProfileScreenProvider>(
            builder: (context, valueModel, child) {
          return Form(
            key: valueModel.formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Text(
                    "Enter your PIN code",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Text(
                    email,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: PinCodeWidget(cont: valueModel.pinConfirmContorller),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      // Text(
                      //   'Forget Pin?',
                      //   style: TextStyle(fontWeight: FontWeight.w500),
                      // ),
                      Text(
                        'LogOut',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomButton(
                    onPress: () {
                      log('kkk ${valueModel.pinConfirmContorller.text}');
                      if (pinCode == valueModel.pinConfirmContorller.text) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      }
                    },
                    text: "Confirm",
                    color: Colors.blue.withOpacity(.8),
                    fontColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }
}

class PinCodeWidget extends StatelessWidget {
  PinCodeWidget({
    Key? key,
    required this.cont,
  }) : super(key: key);

  TextEditingController cont;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: cont,
      appContext: context,
      length: 4,
      obscureText: true,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(2),
        fieldHeight: 70,
        fieldWidth: 70,
        activeFillColor: const Color(0xfffeaedf0),
        activeColor: const Color(0xfffeaedf0),
        inactiveFillColor: const Color(0xfffeaedf0),
        inactiveColor: const Color(0xfffeaedf0),
        selectedColor: const Color(0xfffeaedf0),
        selectedFillColor: const Color(0xfffeaedf0),
      ),
    );
  }
}
