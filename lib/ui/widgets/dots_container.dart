import 'package:flutter/material.dart';

class DotsContainer extends StatelessWidget {
 final int index;
 final int? currentPage ;

  const DotsContainer({Key? key, required this.index, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(5),
      height: 7,
      width:currentPage == index ? 20 : 7,
      decoration: BoxDecoration(
          color: currentPage == index
              ? Theme.of(context).colorScheme.primary
              : const Color(0xffD6D6D6),
          borderRadius:  BorderRadius.circular(3)),
      duration: const Duration(milliseconds: 300),
    );
  }
}
