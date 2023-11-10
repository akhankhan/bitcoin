import 'package:bitcoinapp/model/user.dart';
import 'package:bitcoinapp/screens/dashboard/dashboard.dart';
import 'package:bitcoinapp/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'firebase_options.dart';
import 'screens/profile_screen/lock_screen.dart';

void main() async {
  // final wsUrl = Uri.parse('ws://localhost:1234');
  // var channel = WebSocketChannel.connect(wsUrl);

  // channel.stream.listen((message) {
  //   channel.sink.add('received!');
  //   channel.sink.close();
  // });
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51O4mg3AwPsZVIyyP3Ao9g0dcm1aJ7A673usZ9RSKIiz3uqBk223rQ2ErQLMuW0Qh7w7EwOxM2UjGUFCs3PBC45Hw00RpVMXckU';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const AuthenticationWrapper(),
          );
        });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return FutureBuilder<bool>(
            future: checkEmailIsVerified(snapshot.data!.uid),
            builder: (context, emailSnapshot) {
              if (emailSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (emailSnapshot.hasData) {
                bool? isEmailVerified = emailSnapshot.data;
                if (isEmailVerified!) {
                  return FutureBuilder<UserModel?>(
                    future: getUserData(snapshot.data!.uid),
                    builder: (context, userDataSnapshot) {
                      if (userDataSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userDataSnapshot.hasData) {
                        UserModel? userData = userDataSnapshot.data;
                        bool hasPinCode = userData!.isPinCode == true;
                        return hasPinCode
                            ? LockScreen(
                                name: userData.name.toString(),
                                email: userData.email.toString(),
                                pinCode: userData.pinCode.toString(),
                              )
                            : const Dashboard();
                      }
                      return SplashScreen();
                    },
                  );
                }
              }
              return SplashScreen();
            },
          );
        } else {
          return SplashScreen();
        }
      },
    );
  }

  Future<bool> checkEmailIsVerified(String uid) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        return UserModel(
          name: data['name'],
          email: data['email'],
          pinCode: data['pinCode'],
          isPinCode: data['isPinCode'],
        );
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
