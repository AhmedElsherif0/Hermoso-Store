import 'package:flutter/material.dart';

import '../widgets/custom_widgets/custom_form_field.dart';
import '../widgets/custom_widgets/custom_text_button.dart';

class UpdateUserModalSheet extends StatelessWidget {
  const UpdateUserModalSheet(
      {Key? key,
      required this.onPressed,
      required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.formKey})
      : super(key: key);

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Spacer(),
            CustomFormField(
              controller: nameController,
              labelText: 'Name',
              hintText: 'Edit Your Name',
              textInputType: TextInputType.name,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Name must be Edit';
                }
                return null;
              }, suffixIcon: const Icon(null),
            ),
            const Spacer(flex: 2),
            CustomFormField(
              suffixIcon: const Icon(null),
              controller: emailController,
              labelText: 'Email',
              hintText: 'Edit Your Email',
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (!value.contains('@')) {
                  return 'Email must contains \'@\' ';
                }
                return null;
              },
            ),
            const Spacer(flex: 2),
            CustomFormField(
              suffixIcon: const Icon(null),
              controller: phoneController,
              labelText: 'phone',
              hintText: 'Edit Your phone',
              textInputType: TextInputType.phone,
              validator: (value) {
                if (value.length != 11) {
                  return 'phone must be 11 Number';
                }
                return null;
              },
            ),
            const Spacer(flex: 2),
            CustomTextButton(
              text: 'Save',
              onPressed: onPressed,
              alignment: Alignment.center,
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
