import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({
     Key? key,
    required this.widget,
    required this.value,
     required this.color,
  }) : super(key: key);

  final Widget widget;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget,
        Positioned(
          right: 0,
          top: 2,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
