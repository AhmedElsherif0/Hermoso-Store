import 'package:flutter/material.dart';
import '../../utils/responsive_size.dart';

mixin ModalBottomSheetMixin {


  void showModalSheet(BuildContext context , Widget child) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          child: child ,
          height: SizeConfig.getScreenHeight(500),
        ),
      ),
    );
  }

}
