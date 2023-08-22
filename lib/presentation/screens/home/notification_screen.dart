import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/back_ios_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_notification_tile.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  static const routeName = '/notifications';

  _settingsCubit(context) => BlocProvider.of<SettingsCubit>(context);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar().notificationAppBar(
        color: Colors.white,
        isDark: _settingsCubit(context).isDarkMode,
        textStyle: textTheme.headline4?.copyWith(fontWeight: FontWeight.w400),
        onPressed: () {},
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, index) => CustomNotificationTile(
              firstIcon: const Icon(Icons.check_circle),
              onPressedFirstIcon: () {},
              title: 'System',
              subTitle: 'Your Booking #123 has been Successful'),
        ),
      ),
    );
  }
}
