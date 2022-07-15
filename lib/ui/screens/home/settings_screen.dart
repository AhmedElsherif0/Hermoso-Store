import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_form_field.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_text_button.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/loading_widget.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import '../../../cubit/authUser/auth_users_cubit.dart';
import '../../../cubit/home/settings/settings_cubit.dart';
import '../../../data/local_data/shared_preferences.dart';
import '../../widgets/custom_widgets/custom_dropdown_button.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/show_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with ShowAlertMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode),
      body: SingleChildScrollView(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: SizeConfig.getScreenHeight(40)),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.getScreenWidth(9)),
              child: Text('Settings',
                  style: Theme.of(context).textTheme.headline4),
            ),
            SizedBox(height: SizeConfig.getScreenHeight(50)),
            Center(
              child: _buildProfileInformation(context),
            ),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.getScreenWidth(16)),
              width: double.infinity,
              height: SizeConfig.getScreenHeight(50),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              child: Text(
                'PREFERENCES',
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ),
            _buildSwitchThemeButton(),
            _buildLanguageWidget(),
            _logoutWidget()
          ]),
        ),
      ),
    );
  }

  BlocBuilder _buildSwitchThemeButton() {
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            FontAwesomeIcons.solidMoon,
            color: _settingsCubit(context).isDarkMode ? kPrimary : kGreyColor,
          ),
          title: const Text('Night Mood'),
          trailing: Switch.adaptive(
            onChanged: (value) => _settingsCubit(context).switchThemeMode(),
            value: _settingsCubit(context).isDarkMode,
            activeColor: kPrimary,
          ),
        );
      },
    );
  }

  BlocConsumer _logoutWidget() {
    return BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) async {
      if (state is SettingsSuccessState) {
        if (state.authModel.status == true) {
          await SharedPref.removeData(key: 'token');
          print('the settings screen : ${state.authModel.message}');
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoginScreen.routeName, (Route<dynamic> route) => false);
        } else {
          showMeDialog(
              context, state.authModel.message.toString(), 'Please try again');
        }
      }
      if (state is SettingsErrorState) {
        showMeDialog(context, state.error.toString(), 'Please try again');
      }
    }, builder: (context, state) {
      if (state is SettingsLoadingState) {
        return const LoadingWidget();
      }
      return InkWell(
        onTap: () => SettingsCubit.get(context).logOutSettings(),
        child: const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            trailing: Icon(Icons.arrow_forward_ios)),
      );
    });
  }

  Widget _buildProfileInformation(context) {
    return BlocBuilder<AuthUsersCubit, AuthUserStates>(
      builder: (context, state) {
        if (state is SettingsUpdateProfileStateLoading) {
          return const LoadingWidget();
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              height: SizeConfig.getScreenHeight(100),
              width: SizeConfig.getScreenWidth(100),
              child: ClipOval(
                child: FadeInImage(
                  placeholder:
                      const AssetImage('assets/product-placeholder.png'),
                  image: NetworkImage(
                      _settingsCubit(context).authModel.data.image),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/product-placeholder.png');
                  },
                ),
              )),
          SizedBox(height: SizeConfig.getScreenHeight(8)),
          if (state is SettingsUpdateProfileStateLoading) const LoadingWidget(),
          Wrap(
              spacing: SizeConfig.getScreenWidth(2),
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Text(_settingsCubit(context).authModel.data.name,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('${_settingsCubit(context).authModel.data.phone}',
                    style: Theme.of(context).textTheme.subtitle2),
                Text(_settingsCubit(context).authModel.data.email,
                    style: Theme.of(context).textTheme.subtitle2),
              ]),
          CustomElevatedButton(
            text: 'Edit Profile',
            onPress: state is SettingsUpdateProfileStateLoading
                ? () {}
                : () => _editUserProfile(context),
            width: SizeConfig.getScreenWidth(170),
          ),
        ]);
      },
    );
  }

  SettingsCubit _settingsCubit(context) => SettingsCubit.get(context);

  void _editUserProfile(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: _nameController,
                  labelText: 'Name',
                  hintText: 'Edit Your Name',
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name must be Edit';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.getScreenHeight(30)),
                CustomFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Edit Your Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!value.contains('@')) {
                      return 'Email must contains \'@\' ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.getScreenHeight(30)),
                CustomFormField(
                  controller: _phoneController,
                  labelText: 'phone',
                  hintText: 'Edit Your phone',
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    if (value.length != 11) {
                      return 'phone must be 11 Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                CustomTextButton(
                  text: 'Save',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      _settingsCubit(context).updateUserProfile(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _phoneController.text.trim());
                      Navigator.of(context).pop();
                    }
                    _clearTextField();
                  },
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(20),
          height: SizeConfig.getScreenHeight(500),
        ),
      ),
    );
  }

  Widget _buildLanguageWidget() {
    return const ListTile(
        leading: Icon(Icons.language),
        title: Text('Language'),
        trailing: CustomDropDownButton());
  }

  void _clearTextField() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }
}
