import 'package:flutter/material.dart';

class DotsContainer extends StatelessWidget {
   DotsContainer({required this.currentPage , required this.index});
 final int index;
 final int? currentPage ;

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
      duration: Duration(milliseconds: 300),
    );
  }
}
