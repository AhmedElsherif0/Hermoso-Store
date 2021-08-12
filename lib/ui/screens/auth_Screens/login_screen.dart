import 'package:firstdesign/ui/widgets/login_form_body.dart';
import 'package:firstdesign/ui/widgets/header_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/Login-Screen';

  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              HeaderTexts(
                  title: 'LOGIN',
                  subTitle:
                      'Sign In with email and password \n or Continue with social media'),
              const Spacer(),
              Expanded( flex:8,child: LoginFormBody()),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
