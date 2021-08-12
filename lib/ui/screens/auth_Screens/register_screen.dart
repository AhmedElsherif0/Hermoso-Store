import 'package:firstdesign/ui/widgets/header_text.dart';
import 'package:firstdesign/ui/widgets/register_form_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
          HeaderTexts(
              title: 'Register',
              subTitle:
                  'Complete your details or Continue \n with social media'),
               SizedBox(height: size.height * 0.05),
              Expanded(child: RegisterFormBody()),
            ],
          ),
        ),
      ),
    );
  }
}
