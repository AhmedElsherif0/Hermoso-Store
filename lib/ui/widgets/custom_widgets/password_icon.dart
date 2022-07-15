import 'package:flutter/material.dart';

class PasswordIcon extends StatelessWidget {
  const PasswordIcon(
      {Key? key, required this.isPassword, required this.onPressed})
      : super(key: key);

  final bool isPassword;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: isPassword
        ? const Icon(Icons.visibility_off_outlined):
        const Icon(Icons.visibility_outlined),
    onPressed: onPressed /*() {
          setState(() {
            _isConfirmPassword = !_isConfirmPassword;
          });*/

  );
}}
