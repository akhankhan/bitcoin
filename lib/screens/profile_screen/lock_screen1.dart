import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:bitcoinapp/screens/profile_screen/profile_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class LockScreen1 extends StatelessWidget {
  const LockScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PIN Code Screen"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ChangeNotifierProvider(
              create: (_) => ProfileScreenProvider(),
              child: Consumer<ProfileScreenProvider>(
                  builder: (context, valueModel, child) {
                return Form(
                  key: valueModel.formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      valueModel.isShowConfirmScreen == true
                          ? const Text("Confirm your code")
                          : const Text(
                              "Enter your PIN code",
                              style: TextStyle(fontSize: 20),
                            ),
                      const SizedBox(height: 20),
                      valueModel.isShowConfirmScreen == true
                          ? PinCodeWidget(cont: valueModel.pinConfirmContorller)
                          : PinCodeConfirmWidget(
                              cont: valueModel.pinContorller),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomButton(
                          onPress: () {
                            valueModel.isShowConfirmScreen == false
                                ? valueModel.toggleShowConfirmScreen()
                                : null;
                            valueModel.savePin();
                          },
                          text: valueModel.isShowConfirmScreen == true
                              ? "Confirm"
                              : "Next",
                          fontColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
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

class PinCodeConfirmWidget extends StatelessWidget {
  PinCodeConfirmWidget({
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
