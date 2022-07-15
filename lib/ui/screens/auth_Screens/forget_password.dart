import 'package:hermoso_store/ui/screens/auth_Screens/register_screen.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_form_field.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_text_button.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/header_text.dart';
import 'package:flutter/material.dart';

import '../../../cubit/home/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';

class ForgetPassword extends StatelessWidget {
  static const routeName = '/forget_Password';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          backButton: const BackIosButton(),
          isDark: _settingsCubit(context).isDarkMode,
          barHeight: 40.0,
          color: kWhiteColor),
      backgroundColor: _settingsCubit(context).isDarkMode ? null : kWhiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const HeaderTexts(
                title: 'Forget Password',
                subTitle: 'Please enter your email and we will send\n '
                    'you a link to return your account ',
              ),
              const Spacer(),
              CustomFormField(
                hintText: 'Enter your Email',
                labelText: 'Email',
                suffixIcon: const Icon(Icons.mail_outlined),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@' '.com')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomElevatedButton(text: 'Send', onPress: () {}),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: Theme.of(context).textTheme.subtitle1),
                    CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SettingsCubit _settingsCubit(context) => SettingsCubit.get(context);
}
