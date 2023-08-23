import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hermoso_store/presentation/views/profile_information_view.dart';
import 'package:hermoso_store/presentation/views/update_user_modal_sheet_view.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_text.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/logout_list_tile.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

import '../../../data/model/auth_model/auth_model.dart';
import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/custom_dropdown_button.dart';
import '../../widgets/custom_widgets/loading_widget.dart';
import '../../widgets/modal_bottom_sheet.dart';
import '../../widgets/show_dialog.dart';
import '../../widgets/show_snack_bar.dart';
import '../auth_Screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SnackBarMixin, AlertDialogMixin, ModalBottomSheetMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthModel authModel = AuthModel();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    if (authModel.data.name == 'EmptyName') {
      _settingsCubit(context).getUserProfile();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onSaveModelData() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _settingsCubit(context).updateUserProfile(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim());
      Navigator.of(context).pop();
    }
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  SettingsCubit _settingsCubit(context) => BlocProvider.of<SettingsCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar()
          .changeAppAndStatusBarColor(isDark: _settingsCubit(context).isDarkMode),
      body: Center(
        child: BlocConsumer<SettingsCubit, SettingsStates>(
          listener: (context, state) {
            if (state is SettingsSuccessState) {
              if (state.authModel.status == true) {
                print('the settings screen : ${state.authModel.message}');
                showSnackBar(context, state.authModel.message.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              }
            }
            if (state is SettingsErrorState) {
              showAlertDialog(context, state.error.toString(), 'Please try again');
            }
          },
          builder: (context, state) {
            if (state is SettingsLoadingState) const LoadingWidget();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.getScreenWidth(9)),
                  child:
                      Text('Settings', style: Theme.of(context).textTheme.headline4),
                ),
                Expanded(
                  flex: 9,
                  child: Center(
                    child: ProfileInformationView(
                      image: _settingsCubit(context).authModel.data.image,
                      name: _settingsCubit(context).authModel.data.name,
                      email: _settingsCubit(context).authModel.data.email,
                      phone: _settingsCubit(context).authModel.data.phone,
                      onPressed: () => showModalSheet(
                        context,
                        UpdateUserModalSheet(
                          emailController: _emailController,
                          nameController: _nameController,
                          phoneController: _phoneController,
                          formKey: _formKey,
                          onPressed: () => onSaveModelData(),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const CustomText(text: 'PREFERENCES'),
                CustomListTile(
                  icon: FontAwesomeIcons.solidMoon,
                  title: 'Night Mood',
                  onTap: () => _settingsCubit(context).switchThemeMode(),
                  isDarkMode: _settingsCubit(context).isDarkMode,
                  trailingWidget: Switch.adaptive(
                    onChanged: (value) => _settingsCubit(context).switchThemeMode(),
                    value: _settingsCubit(context).isDarkMode,
                    activeColor: AppColor.kPrimaryColor,
                  ),
                ),
                CustomDropDownButton(settingsCubit: _settingsCubit(context)),
                CustomListTile(
                  icon: Icons.logout,
                  title: 'Log out',
                  onTap: () {
                    showLogoutDialog('Are You Ready to Leave', context, '',
                        onPressed: () async {
                      await _settingsCubit(context).logOutSettings();
                      Navigator.of(context).pop(true);
                    });
                  },
                  isDarkMode: _settingsCubit(context).isDarkMode,
                  trailingWidget: const Icon(Icons.arrow_forward_ios),
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}
