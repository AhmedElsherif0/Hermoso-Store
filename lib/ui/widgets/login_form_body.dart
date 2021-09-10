import 'package:hermoso_store/cubit/login_cubit/login_cubit.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/forget_password.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/register_screen.dart';
import 'package:hermoso_store/ui/screens/home/home_page.dart';
import 'package:hermoso_store/ui/widgets/custom_text_button.dart';
import 'package:hermoso_store/ui/widgets/row_text_and_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './custom_elevated_button.dart';
import './custom_form_field.dart';
import 'package:flutter/material.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({Key? key}): super(key :key);

  @override
  _LoginFormBodyState createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String>? _authMode = {'email': '', 'password': ''};
  bool isPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            await SharedPref.saveStringData(
                key: 'token', value: state.authModel.data?.token);
            Navigator.pushNamed(context, HomeScreen.routeName);
          }
          if (state is LoginErrorState) {
            buildAlertsDialog(context, 'Something Went Error',
                state.error.toString(), state is LoginErrorState);
          }
        },
        builder: (context, state) => Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                labelText: 'Email',
                hintText: 'Enter Your Email',
                suffixIcon: const Icon(Icons.mail_outlined),
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authMode?['email'] = value!;
                },
              ),
              const SizedBox(height: 20),
              CustomFormField(
                textInputType: TextInputType.visiblePassword,
                obscureText: isPassword ? false : true,
                labelText: 'Password',
                hintText: 'Enter Your Password',
                controller: _passwordController,
                suffixIcon: IconButton(
                    icon: isPassword
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    }),
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authMode?['password'] = value!;
                },
              ),
              const SizedBox(height: 30),
              CustomTextButton(
                  text: 'Forget Password',
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPassword.routeName);
                  }),
              if (state is LoginLoadingState)
                const Center(child: CircularProgressIndicator()),
              CustomElevatedButton(
                  text: 'Login',
                  onPress: state is LoginLoadingState ? null : _onLogin),
              const SizedBox(height: 10),
              RowTextAndButton(
                  title: 'Don\'t have an Account? ',
                  text: 'Sign UP',
                  onPressed: () =>
                      Navigator.pushNamed(context, RegisterScreen.routeName)),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      LoginCubit.get(context).userLogin(
          _emailController.text.trim(), _passwordController.text.trim());
      _formKey.currentState!.save();
    }
    _formKey.currentState!.save();
  }

  Future<bool> buildAlertsDialog(
      BuildContext context, title, message, state) async {
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titleTextStyle: const TextStyle(color: Colors.black),
              title: Text(title),
              content: Text(message),
              actions: [
                if (state)
                  TextButton(
                      onPressed: () => Navigator.of(context).pop,
                      child: const Text('ok')),
                TextButton(onPressed: () {}, child: const Text('yes')),
                TextButton(onPressed: () {}, child: const Text('No')),
              ],
            ));
    return action;
  }
}
