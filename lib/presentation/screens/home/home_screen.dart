import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubit/global_cubit/home/home_cubit.dart';
import '../../widgets/nav_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) => Scaffold(
        body: _cubit.navigationBottomScreens[_cubit.currentIndex],
        bottomNavigationBar: NavBottomBar(
            currentIndex: _cubit.currentIndex,
            onTap: (value) => _cubit.changeIndex(value)),
      ),
    );
  }
}
