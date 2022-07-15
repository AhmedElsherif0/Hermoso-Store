import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {required this.labelText,
      required this.hintText,
      required this.textInputType,
       this.suffixIcon,
      this.obscureText,
      this.validator,
       this.onSaved, this.controller,Key? key}) : super (key: key);

  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final FormFieldValidator? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
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
      gapPadding:  10,
    );
  }
}
