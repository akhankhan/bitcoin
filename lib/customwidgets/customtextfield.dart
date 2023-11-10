// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final onChanged;
//   final validator;
//   final hintText;
//   final hintTextColor;
//   final fontColor;
//   final borderColor;
//   final fillColor;
//   final focusBorderColor;
//   final controller;
//   final preFixIcon;
//   bool obscureText;
//   final textInputAction;
//   final keyBoardType;
//   bool? autofocus;
//   IconButton? suffixIcon;
//   FocusNode? focusNode;
//   Function(String)? onFieldSubmitted;
//   final VoidCallback? onTap;

//   CustomTextField({
//     this.onTap,
//     this.preFixIcon,
//     this.suffixIcon,
//     this.onChanged,
//     this.controller,
//     this.hintText,
//     this.hintTextColor = Colors.white,
//     this.fontColor = Colors.white,
//     this.borderColor = Colors.white,
//     this.focusBorderColor = Colors.white,
//     this.fillColor = Colors.white38,
//     this.validator,
//     this.obscureText = false,
//     this.textInputAction,
//     this.keyBoardType,
//     this.focusNode,
//     this.onFieldSubmitted,
//     EdgeInsets? contentPadding,
//     this.autofocus,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         primaryColor: Colors.grey, // Outline border color
//         primaryColorDark: Colors.grey, // Outline border color when focused
//       ),
//       child: TextFormField(
//         readOnly: false,
//         onTap: onTap,
//         onEditingComplete: () {},
//         autofocus: autofocus ?? false,
//         keyboardType: keyBoardType,
//         textInputAction: TextInputAction.next,
//         onChanged: onChanged,
//         validator: validator,
//         controller: controller,
//         obscureText: obscureText,
//         onFieldSubmitted: onFieldSubmitted,
//         focusNode: focusNode,
//       //  cursorColor: primaryColor,
//         style: TextStyle(fontSize: 16, color: fontColor),
//         decoration: InputDecoration(
//           hintText: hintText,
//           fillColor: fillColor, // Fill color
//           filled: true,
//           prefix: preFixIcon,
//           suffixIcon: suffixIcon,
//           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: borderColor, width: 2),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           hintStyle: TextStyle(
//             fontSize: 15.0,
//             color: hintTextColor,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: focusBorderColor, width: 2),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final preFixIcon;
  bool obscureText;
  final textInputAction;
  final keyBoardType;
  IconButton? suffixIcon;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;
  final maxLines;
  final labeltext;
  final readOnly;

  CustomTextField({
    super.key,
    this.labeltext,
    this.preFixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyBoardType,
    this.focusNode,
    this.onFieldSubmitted,
    EdgeInsets? contentPadding,
    this.maxLines,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey, // Outline border color
        primaryColorDark: Colors.grey, // Outline border color when focused
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        style: TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,

          fillColor: Color(0XFFDBE2E9).withOpacity(0.3), // Fill color
          filled: true,
          prefix: preFixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            // Add this to specify the border
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFDBE2E9), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDBE2E9), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),

          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF9EA3AD),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
