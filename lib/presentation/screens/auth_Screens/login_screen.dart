import 'package:hermoso_store/cubit/home/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/views/login_form_body.dart';
import 'package:hermoso_store/utils/colors.dart';

import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/header_text.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/Login-Screen';

  const LoginScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode,
          color: kWhiteColor, barHeight: 40),
      backgroundColor: _settingsCubit(context).isDarkMode? null : kWhiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: const [
              HeaderTexts(
                  title: 'LOGIN',
                  subTitle:
                      'Sign In with email and password \n or Continue with social media'),
              Spacer(),
              Expanded(flex: 8, child: LoginFormBody()),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  SettingsCubit _settingsCubit(context) => SettingsCubit.get(context);
}
