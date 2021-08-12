import 'package:firstdesign/ui/screens/auth_Screens/register_screen.dart';
import 'package:firstdesign/ui/widgets/custom_elevated_button.dart';
import 'package:firstdesign/ui/widgets/custom_form_field.dart';
import 'package:firstdesign/ui/widgets/custom_text_button.dart';
import 'package:firstdesign/ui/widgets/header_text.dart';
import 'package:firstdesign/utils/style.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  static const routeName = '/forget_Password';

  const ForgetPassword();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Forget'),
          leading: const Icon(Icons.arrow_back_ios)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              HeaderTexts(
                title: 'Forget Password',
                subTitle:
                    'Please enter your email and we will send\n you a link to return your account ',
              ),
              const Spacer(),
              CustomFormField(
                hintText: 'Enter your Email',
                labelText: 'Email',
                suffixIcon: const Icon(Icons.mail_outlined),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
              ),
              const Spacer(),
              CustomElevatedButton(text: 'Send', onPress: () {}),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?', style: kTitleStyle),
                    CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
