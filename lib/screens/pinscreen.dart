// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreen extends StatelessWidget {
  PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 2.2,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/Profile.png',
                      color: Colors.white,
                      height: 70,
                      width: 70,
                    ),
                    SizedBox(height: 13.0),
                    Text(
                      ' Christ Wayne',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'chris@gmail.com',
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                    SizedBox(height: 20.0),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      onChanged: (pin) {},
                      pinTheme: PinTheme(
                        fieldOuterPadding: EdgeInsets.only(left: 25, right: 25),
                        shape: PinCodeFieldShape.underline,
                        borderWidth: 2,
                        inactiveColor: Colors.white,
                        activeColor: Colors.white,
                        selectedColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Pin?',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        TextButton(
                          onPressed: () {
                            // Add functionality for "Logout"
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
