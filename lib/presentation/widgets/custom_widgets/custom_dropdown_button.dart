import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/utils/colors.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    Key? key,
    required this.settingsCubit,
  }) : super(key: key);
  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
      print('settings screen language');
      return ListTile(
        leading: Icon(Icons.language,
            color: settingsCubit.isDarkMode
                ? AppColor.kPrimaryColor
                : AppColor.kGreyColor),
        title: const Text('Language'),
        trailing: DropdownButton<String>(
          value: settingsCubit.dropDownValue,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_forward_ios),
          onChanged: (String? newValue) => settingsCubit.changeLanguage(newValue),
          items: <String>['English', 'Arabic']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      );
  }
}
