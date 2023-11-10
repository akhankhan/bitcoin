import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  final Color color;
  final double fontSize;
  final Color fontColor;
  final double width;
  final double height;
  final VoidCallback? onPress;
  CustomButton({
    required this.text,
    this.onPress,
    this.color = Colors.blue,
    this.fontColor = Colors.black,
    this.fontSize = 16.0,
    this.width = double.infinity,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: fontSize,
                  color: fontColor,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
