import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/show_dialog.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../screens/auth_Screens/login_screen.dart';
import 'loading_widget.dart';

class CustomListTile extends StatelessWidget with SnackBarMixin, AlertDialogMixin {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.trailingWidget,
    required this.title,
    required this.isDarkMode,
    required this.icon,
  }) : super(key: key);

  final void Function() onTap;
  final Widget trailingWidget;
  final String title;
  final bool isDarkMode;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) async {
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
    }, builder: (context, state) {
      if (state is SettingsLoadingState) const LoadingWidget();
      return InkWell(
        onTap: onTap,
        child: ListTile(
            leading: Icon(icon,
                color: isDarkMode ? AppColor.kPrimaryColor : AppColor.kGreyColor),
            title: Text(title),
            trailing: trailingWidget),
      );
    });
  }
}
