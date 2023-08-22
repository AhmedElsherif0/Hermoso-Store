import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_widgets/back_ios_button.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_form_field.dart';
import '../../widgets/custom_widgets/custom_text_button.dart';
import '../../widgets/custom_widgets/header_text.dart';
import 'register_screen.dart';

class ForgetPassword extends StatelessWidget {
  static const routeName = '/forget_Password';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('the size of the device is : ${size.width}');
    print('the height of the device is : ${size.height}');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar().changeAppAndStatusBarColor(
            isDark: _settingsCubit(context).isDarkMode,
            color: AppColor.kWhiteColor),
        backgroundColor:
            _settingsCubit(context).isDarkMode ? null : AppColor.kWhiteColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.h),
            child: SizerUtil.orientation == Orientation.landscape
                ? _orientationLandScapeMode(context)
                : _orientationPortraitMode(context),
          ),
        ),
      ),
    );
  }

  Widget _orientationLandScapeMode(context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Column(
            children: const [
              Spacer(),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: BackIosButton(
                      backgroundColor: AppColor.kCoWhiteColor,
                    )),
              ),
              Expanded(
                flex: 15,
                child: HeaderTexts(
                  title: 'Forget Password',
                  subTitle: 'Please enter your email and we will send\n '
                      'you a link to return your account ',
                ),
              ),
            ],
          ),
        ),
        if (SizerUtil.orientation == Orientation.landscape) const Spacer(),
        Expanded(
          flex: 10,
          child: Form(
            child: Column(
              children: [
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
                CustomElevatedButton(text: 'Send', onPressed: () {}),
                const Spacer(),
                if (SizerUtil.orientation == Orientation.portrait)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: Theme.of(context).textTheme.subtitle1),
                      CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                      )
                    ],
                  ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _orientationPortraitMode(context) {
    return Column(
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: BackIosButton(
              backgroundColor: AppColor.kCoWhiteColor,
            ),
          ),
        ),

        const Expanded(
          flex: 3,
          child: HeaderTexts(
            title: 'Forget Password',
            subTitle: 'Please enter your email and we will send\n '
                'you a link to return your account ',
          ),
        ),
        Expanded(
            flex: 9,
            child: Form(
              child: Column(
                children: [
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
                  CustomElevatedButton(text: 'Send', onPressed: () {}),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: Theme.of(context).textTheme.subtitle1),
                      CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                      )
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ))
      ],
    );
  }

  SettingsCubit _settingsCubit(context) =>   BlocProvider.of<SettingsCubit>(context);
}
