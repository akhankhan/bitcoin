import 'dart:developer';

import 'package:bitcoinapp/screens/welcomescreen/welcomescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  // String? userId;
  // String? userType;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
    _animation.addStatusListener((status) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
      // Navigator.pushReplacement(
      //   context,
      //   PageRouteAnimator(
      //     child: UserSelectionScreen(),
      //     routeAnimation: RouteAnimation.bottomToTopWithScale,
      //     settings: const RouteSettings(arguments: 'I am going'),
      //     curve: Curves.decelerate,
      //     duration: const Duration(milliseconds: 500),
      //     reverseDuration: const Duration(milliseconds: 500),
      //   ),
      // );
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/skyvalletlogo.png',
                height: 180,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
