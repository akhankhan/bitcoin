// ignore_for_file: prefer_const_constructors

import 'package:bitcoinapp/customwidgets/change_password_bottomSheet.dart';
import 'package:bitcoinapp/screens/profile_screen/lock_screen.dart';
import 'package:bitcoinapp/screens/profile_screen/lock_screen1.dart';
import 'package:flutter/material.dart';

import 'profile_screen_provider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    Key? key,
    required this.valueModel,
  }) : super(key: key);

  final ProfileScreenProvider valueModel;

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isBiometricEnabled =
      false; // Track the state of biometric authentication

  @override
  Widget build(BuildContext context) {
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
          'Security',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 15, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Open the bottom sheet when the icon is tapped
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangePasswordBottomSheet(
                          valueModel: widget.valueModel,
                        );
                      },
                    );
                  },
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color(0xff3938605e),
                  thickness: 1,
                  indent: 1,
                ),
                SizedBox(height: 20),
                Text(
                  'Change Transaction Pin',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color(0xff3938605e),
                  thickness: 1,
                  indent: 1,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LockScreen1()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Enable Screen Lock',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.teal,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enable biometric for authentication',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal,
                      ),
                    ),
                    Switch(
                      value: isBiometricEnabled,
                      onChanged: (newValue) {
                        setState(() {
                          isBiometricEnabled = newValue;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color(0xff3938605e),
                  thickness: 1,
                  indent: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
