import 'package:flutter/material.dart';

class PasswordIcon extends StatelessWidget {
  const PasswordIcon({
    Key? key,
    required this.isPassword,
  }) : super(key: key);

  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
    );
  }
}
