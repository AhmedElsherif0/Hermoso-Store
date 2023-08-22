import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {required this.labelText,
      required this.hintText,
      required this.textInputType,
      required this.suffixIcon,
      this.obscureText,
      this.validator,
      this.onSaved,
      this.controller,
      Key? key,
      this.onPressIcon})
      : super(key: key);

  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final Widget suffixIcon;
  final bool? obscureText;
  final FormFieldValidator? validator;
  final void Function(String?)? onSaved;
  final void Function()? onPressIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
        validator: validator,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            suffixIcon: IconButton(
                onPressed: onPressIcon, icon: suffixIcon, iconSize: 3.h),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                 EdgeInsets.symmetric(horizontal: 36, vertical: 2.h),
            enabledBorder: _outlineInputBorder(),
            focusedBorder: _outlineInputBorder(),
            focusedErrorBorder: _outlineInputBorder(),
            errorBorder: _outlineInputBorder()),
        onSaved: onSaved,
        obscureText: obscureText ?? false,
      );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.black),
      gapPadding: 10,
    );
  }
}
