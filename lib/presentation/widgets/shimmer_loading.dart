import 'package:flutter/material.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultValue = 12.0;
    return
      SizedBox(
        width: 200.0,
        height: 100.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const ShimmerContainer(height: 120, width: 120),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const ShimmerContainer(
                            width: 80, height: defaultValue),
                        const SizedBox(height: 8),
                        const ShimmerContainer(
                            width: double.infinity, height: defaultValue),
                        const SizedBox(height: 8),
                        const ShimmerContainer(
                            width: double.infinity, height: defaultValue),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Expanded(child: ShimmerContainer(
                                height: defaultValue)),
                            SizedBox(height: 8),
                            Expanded(
                                child: ShimmerContainer(height: defaultValue))
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),);
  }
}
