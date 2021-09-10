import 'package:hermoso_store/ui/widgets/header_text.dart';
import 'package:hermoso_store/ui/widgets/register_form_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermoso_store/utils/responsive_size.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
          const HeaderTexts(
              title: 'Register',
              subTitle:
                  'Complete your details or Continue \n with social media'),
               SizedBox(height: getScreenHeight( 70.0) ),
              const Expanded(child: RegisterFormBody()),
            ],
          ),
        ),
      ),
    );
  }
}
