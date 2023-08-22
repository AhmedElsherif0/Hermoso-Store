import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShimmerListSeparated extends StatelessWidget {
  const ShimmerListSeparated({
    Key? key,
    required this.child,
    this.itemCount = 5,
    this.direction = Axis.vertical,
  }) : super(key: key);

  final Widget child;
  final int itemCount;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: direction,
      itemCount: itemCount,
      itemBuilder: (context, index) => child,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
