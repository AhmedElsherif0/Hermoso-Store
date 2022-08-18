import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/colors.dart';

class CustomSwitchTile extends StatelessWidget {
  const CustomSwitchTile(
      {Key? key,
      required this.iconColor,
      required this.onChanged,
      required this.value})
      : super(key: key);

  final Color iconColor;
  final void Function(bool) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(FontAwesomeIcons.solidMoon, color: iconColor),
      title: const Text('Night Mood'),
      trailing: Switch.adaptive(
        onChanged: onChanged,
        value: value,
        activeColor: AppColor.kPrimaryColor,
      ),
    );
  }
}
