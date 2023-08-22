import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile(
      {this.image,
      required this.title,
      this.firstIcon = const Icon(Icons.chat),
      this.secondIcon = const Icon(Icons.phone),
      Key? key,
      this.onPressedFirstIcon,
      this.rateReview,
      this.rateTextStyle = const TextStyle(color: Colors.grey),
      this.onPressedSecondIcon,
      this.backgroundColor = Colors.white,
       this.placeHolderImage, this.subTitle})
      : super(key: key);

  final String? image;
  final String? title;
  final String? subTitle;
  final Widget? firstIcon;
  final Widget? secondIcon;
  final VoidCallback? onPressedFirstIcon;
  final VoidCallback? onPressedSecondIcon;
  final double? rateReview;
  final TextStyle rateTextStyle;
  final Color backgroundColor;
  final String? placeHolderImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
               const Spacer(),
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor.kPrimaryColor.withOpacity(0.2),
                    child: IconButton(
                      onPressed: onPressedFirstIcon,
                      icon: firstIcon!,
                      color: AppColor.kSecondaryContainerColor,
                      iconSize: 26,
                    ),
                  ),
                ),
               const Spacer(),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 2),
                      FittedBox(
                        child: Text(
                          title??'',
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        subTitle??'',
                        style: Theme.of(context).textTheme.subtitle2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(flex: 2)
                    ],
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
          const Divider(
            color: AppColor.kBackButtonColor,
            thickness: 1.0,
          )
        ],
      ),
    );
  }
}
