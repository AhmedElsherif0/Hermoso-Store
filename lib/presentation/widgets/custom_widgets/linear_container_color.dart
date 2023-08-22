import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../../utils/colors.dart';

class LinearContainerColor extends StatelessWidget {
  const LinearContainerColor({
    Key? key,
    required this.child,
    required this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.0, 0.8],
          colors: BlocProvider.of<SettingsCubit>(context).isDarkMode
              ? AppColor.darkGreenLinear
              : AppColor.lightGreenLinear,
        ),
      ),
      child: child,
    );
  }
}
