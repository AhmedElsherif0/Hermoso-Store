import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/modal_bottom_sheet.dart';
import '../../domain/cubit/authUser/auth_users_cubit.dart';
import '../../domain/cubit/global_cubit/settings/settings_cubit.dart';
import '../../utils/responsive_size.dart';
import '../widgets/custom_widgets/custom_circle_image.dart';
import '../widgets/custom_widgets/custom_elevated_button.dart';
import '../widgets/custom_widgets/loading_widget.dart';

class ProfileInformationView extends StatelessWidget
    with ModalBottomSheetMixin {
  const ProfileInformationView(
      {Key? key,
      required this.name,
      required this.phone,
      required this.image,
      required this.email,
      required this.onPressed})
      : super(key: key);

  final String name;
  final String? phone;
  final String image;
  final String email;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUsersCubit, AuthUserStates>(
      builder: (context, state) {
        if (state is SettingsUpdateProfileStateLoading) {
          return const LoadingWidget();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: CustomCircleImage(networkImage: image),
            ),
            if (state is SettingsUpdateProfileStateLoading)
              const LoadingWidget(),
            Expanded(
              flex: 4,
              child: Column(children: [
                FittedBox(
                    child: Text(name,
                        style: Theme.of(context).textTheme.subtitle1)),
                const Spacer(),
                FittedBox(
                    child: Text('${phone}',
                        style: Theme.of(context).textTheme.subtitle2)),
                const Spacer(),
                FittedBox(
                    child: Text(email,
                        style: Theme.of(context).textTheme.subtitle2)),
                const Spacer(flex: 3),
                CustomElevatedButton(
                  width: SizeConfig.getScreenWidth(170),
                  text: 'Edit Profile',
                  onPressed: state is SettingsUpdateProfileStateLoading
                      ? () {}
                      : onPressed,
                ),
                const Spacer(flex: 3),
              ]),
            ),
          ],
        );
      },
    );
  }
}
