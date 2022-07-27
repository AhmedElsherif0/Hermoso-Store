import 'package:flutter/material.dart';
import 'package:hermoso_store/cubit/home/settings/settings_cubit.dart';

import '../../widgets/custom_widgets/custom_action_appbar.dart';
import '../../widgets/custom_widgets/empty_screen.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);
  static const routeName = '/notification-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: changeAppAndStatusBarColor(
          isDark: _settingsCubit(context).isDarkMode),
      body: const EmptyScreen(),
    );
  }

  SettingsCubit _settingsCubit(context)=> SettingsCubit.get(context);
}
