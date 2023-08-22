import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/colors.dart';
import 'package:sizer/sizer.dart';

class NavBottomBar extends StatelessWidget {
  const NavBottomBar({required this.currentIndex, required this.onTap, Key? key})
      : super(key: key);

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        selectedItemColor: AppColor.kSecondaryContainerColor,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 20.sp,
        selectedLabelStyle: TextStyle(fontSize: 10.sp),
        unselectedLabelStyle: TextStyle(fontSize: 10.sp),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: currentIndex,
        onTap: onTap);
  }
}
