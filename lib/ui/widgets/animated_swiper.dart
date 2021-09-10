import 'package:card_swiper/card_swiper.dart';
import 'package:hermoso_store/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class AnimationSwiper extends StatefulWidget {
  final IndexedWidgetBuilder  itemBuilder;
  final int itemLength;

  const AnimationSwiper({Key? key, required this.itemBuilder, required this.itemLength}) : super(key: key);

  @override
  _AnimationSwiperState createState() => _AnimationSwiperState();
}

class _AnimationSwiperState extends State<AnimationSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemHeight: getScreenHeight(200),
      itemCount: widget.itemLength,
      itemBuilder:  widget.itemBuilder,
      autoplay: true,
      viewportFraction: 0.8,
      scale: 0.9,
      physics: const BouncingScrollPhysics(),
    );
  }
}
