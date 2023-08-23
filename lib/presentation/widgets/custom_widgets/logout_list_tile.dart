import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/show_dialog.dart';
import 'package:hermoso_store/presentation/widgets/show_snack_bar.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';
import '../../screens/auth_Screens/login_screen.dart';
import 'loading_widget.dart';

class CustomListTile extends StatelessWidget {
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
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (context, state) {
        return InkWell(
          onTap: onTap,
          child: ListTile(
              leading: Icon(icon,
                  color: isDarkMode ? AppColor.kPrimaryColor : AppColor.kGreyColor),
              title: Text(title),
              trailing: trailingWidget),
        );
      },
    );
  }
}
