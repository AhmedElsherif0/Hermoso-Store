import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/views/register_form_body.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../views/auth_integrations_buttons.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/header_text.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

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
            barHeight: SizerUtil.orientation == Orientation.portrait ? 5.h : 0.0,
          ),
          backgroundColor:
              _settingsCubit(context).isDarkMode ? null : AppColor.kWhiteColor,
          body: _mobileRegisterScreen()),
    );
  }

  SettingsCubit _settingsCubit(context) =>
      BlocProvider.of<SettingsCubit>(context);

  Widget _mobileRegisterScreen() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children:  [
              const Expanded(
                flex: 3,
                child: HeaderTexts(
                    title: 'REGISTER',
                    subTitle:
                        'Complete your details or Continue \n with social media'),
              ),
              const Expanded(flex: 13, child: RegisterFormBody()),
              Expanded(flex: 3,
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

  Widget _tabletRegisterScreen() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: const [
              Expanded(
                flex: 2,
                child: HeaderTexts(
                  title: 'REGISTER',
                  subTitle:
                      'Complete your details or Continue \n with social media',
                ),
              ),
              Expanded(
                flex: 7,
                child: RegisterFormBody(),
              ),
              // Todo : Social Media Authentication
            ],
          ),
        ),
      );
}
