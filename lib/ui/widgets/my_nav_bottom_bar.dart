import 'package:flutter/material.dart';

class MyNavBottomBar extends StatelessWidget {
  const MyNavBottomBar({required this.currentIndex, required this.onTap,Key? key}) :super (key: key);

  final int currentIndex ;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Products',
        ),
        BottomNavigationBarItem(
          icon:  Icon(Icons.favorite_border),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      selectedItemColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap
    );
  }
}
