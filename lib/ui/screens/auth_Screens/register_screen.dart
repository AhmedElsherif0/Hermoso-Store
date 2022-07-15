import 'package:hermoso_store/ui/widgets/custom_widgets/header_text.dart';
import 'package:hermoso_store/ui/widgets/register_form_body.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

import '../../../cubit/home/settings/settings_cubit.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode,
          color: kWhiteColor, barHeight: 40),
      backgroundColor: _settingsCubit(context).isDarkMode? null : kWhiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const HeaderTexts(
                  title: 'REGISTER',
                  subTitle:
                      'Complete your details or Continue \n with social media'),
              SizedBox(height: SizeConfig.getScreenHeight(20.0)),
              const Expanded(child: RegisterFormBody()),
            ],
          ),
        ),
      ),
    );
  }

  SettingsCubit _settingsCubit(context) => SettingsCubit.get(context);
}
