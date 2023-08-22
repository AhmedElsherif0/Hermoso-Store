import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/views/login_form_body.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../views/auth_integrations_buttons.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/header_text.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/Login-Screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('the size of the device is : ${size.width}');
    print('the height of the device is : ${size.height}');
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar().changeAppAndStatusBarColor(
            isDark: _settingsCubit(context).isDarkMode,
            color: AppColor.kWhiteColor,
            barHeight:
                SizerUtil.orientation == Orientation.portrait ? 5.h : 0.0,
          ),
          backgroundColor:
              _settingsCubit(context).isDarkMode ? null : AppColor.kWhiteColor,
          body: _loginMobileScreen()),
    );
  }

  Widget _loginMobileScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: HeaderTexts(
                  title: 'LOGIN',
                  subTitle:
                      'Sign In with email and password \n or Continue with social media'),
            ),
            SizedBox(height: 1.h),
            const Expanded(
              flex: 9,
              child: LoginFormBody(),
            ),
            Expanded(
              flex: 3,
              child: AuthIntegrationsButtons(
                text: 'or Login With',
                onPressApple: () {},
                onPressGmail: () {},
                onPressFacebook: () {},
              ),
            ),
            if (SizerUtil.orientation == Orientation.portrait) const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _loginTabletScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: HeaderTexts(
                    title: 'LOGIN',
                    subTitle:
                        'Sign In with email and password \n or Continue with social media'),
              ),
              const Expanded(
                flex: 6,
                child: LoginFormBody(),
              ),
              Expanded(
                flex: 3,
                child: AuthIntegrationsButtons(
                  text: 'or Login With',
                  onPressApple: () {},
                  onPressGmail: () {},
                  onPressFacebook: () {},
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  SettingsCubit _settingsCubit(context) =>
      BlocProvider.of<SettingsCubit>(context);
}
