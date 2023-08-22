import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../widgets/custom_widgets/custom_icon_button.dart';
import '../widgets/custom_widgets/custom_outline_button.dart';

class AuthIntegrationsButtons extends StatelessWidget {
  const AuthIntegrationsButtons(
      {Key? key,
      required this.onPressFacebook,
      required this.onPressApple,
      required this.onPressGmail,
      required this.text})
      : super(key: key);
  final void Function() onPressFacebook;
  final void Function() onPressApple;
  final void Function() onPressGmail;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: AppColor.kGreyColor),
          ),
        ),
        SizedBox(height: 1.h),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: CustomIconButton(
                  onPressFavorite: onPressFacebook,
                  icon: Icons.facebook,
                  backgroundColor: AppColor.blue,
                  iconSize: 40.sp,
                ),
              ),
              const Spacer(flex: 2),
              Expanded(
                flex: 2,
                child: CustomOutlineButton(
                  onPressed: onPressGmail,
                  icon: FontAwesomeIcons.google,
                  height: 35.sp,
                  width: 35.sp,
                  borderColor: AppColor.kSecondaryColor,
                  iconColor: AppColor.kSecondaryColor,
                ),
              ),
              const Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: CustomIconButton(
                  onPressFavorite: onPressApple,
                  icon: Icons.apple,
                  backgroundColor: AppColor.kBlackColor,
                  iconColor: Theme.of(context).colorScheme.onSurface,
                  iconSize: 40.sp,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
