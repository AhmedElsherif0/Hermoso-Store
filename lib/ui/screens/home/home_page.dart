import 'package:hermoso_store/cubit/home/home_cubit.dart';
import 'package:hermoso_store/ui/screens/home/notification_screen.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/custom_action_appbar.dart';
import 'package:hermoso_store/ui/widgets/nav_bottom_bar.dart';
import 'package:hermoso_store/ui/widgets/search_field.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) => Scaffold(
        body: _cubit.navigationBottomScreens[_cubit.currentIndex],
        bottomNavigationBar: NavBottomBar(
          currentIndex: _cubit.currentIndex,
          onTap: (value) => _cubit.changeIndex(value),
        ),
      ),
    );
  }
}
