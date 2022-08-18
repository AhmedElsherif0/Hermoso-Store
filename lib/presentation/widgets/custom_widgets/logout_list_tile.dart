import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/show_dialog.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../screens/auth_Screens/login_screen.dart';
import 'loading_widget.dart';

class LogoutListTile extends StatelessWidget
    with SnackBarMixin, AlertDialogMixin {
  const LogoutListTile({
    Key? key,
    this.iconColor = AppColor.kGreyColor,
    required this.onTap,
  }) : super(key: key);

  final Color iconColor;
  final void Function() onTap;

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
        showAlertDialog(context,state.error.toString(), 'Please try again');
      }
    }, builder: (context, state) {
      if (state is SettingsLoadingState) {
        return const LoadingWidget();
      }
      return InkWell(
        onTap: onTap,
        child: ListTile(
            leading: Icon(Icons.logout, color: iconColor),
            title: const Text('Log out'),
            trailing: const Icon(Icons.arrow_forward_ios)),
      );
    });
  }
}
