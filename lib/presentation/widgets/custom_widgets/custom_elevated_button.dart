import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final bool isLoading;
  final double width;

  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.onPress,
      this.isLoading = false,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: SizeConfig.getScreenHeight(50),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text( text,
                style:
                     Theme.of(context).textTheme.button,
              ),
      ),
    );
  }
}
