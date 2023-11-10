import 'dart:developer';

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/customwidgets/customtextfield.dart';
import 'package:bitcoinapp/screens/deposit/deposit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => DepositScreenProvider(),
        child: Consumer<DepositScreenProvider>(
            builder: (context, valueModel, child) {
          return Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  controller: valueModel.nameController,
                  readOnly: true,

                  //hintText:  Text(""),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  hintText: 'Enter your payment amount',
                  controller: valueModel.ammountContorller,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  text: "Deposit",
                  fontColor: Colors.white,
                  onPress: () {
                    valueModel.intentPayment();
                    log("");
                  },
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
