import 'package:hermoso_store/cubit/home/home_cubit.dart';
import 'package:hermoso_store/ui/widgets/my_nav_bottom_bar.dart';
import 'package:hermoso_store/ui/widgets/search_field.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor:
            _cubit.currentIndex == 3 ? Colors.white : kBackgroundColor,
        appBar: _cubit.currentIndex == 3
            ? null
            : AppBar(
                actions: [
                  const SearchField(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined,
                          color: Colors.grey, size: 26)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications,
                          color: Colors.grey, size: 26)),
                ],
              ),
        body: _cubit.navigationBottomScreens[_cubit.currentIndex],
        bottomNavigationBar: MyNavBottomBar(
          currentIndex: _cubit.currentIndex,
          onTap: (value) => _cubit.changeIndex(value),
        ),
      ),
    );
  }
}
