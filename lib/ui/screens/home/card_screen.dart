import 'package:flutter/material.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_action_appbar.dart';

import '../../../cubit/home/settings/settings_cubit.dart';
import '../../widgets/custom_widgets/empty_screen.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);
  static const routeName = '/card-Screen';


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