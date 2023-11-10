import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verfication_provider.dart';

class VerficationEmailScreen extends StatelessWidget {
  const VerficationEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => VerificationEmailProvider(context),
        child: Consumer<VerificationEmailProvider>(
            builder: (context, valueModel, child) {
          return Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Email Verifciaton",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Email is sended please check your email and verify your email account.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // valueModel.checkEmailVerified();
                },
                child: const Text(
                  "Resend again",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}

