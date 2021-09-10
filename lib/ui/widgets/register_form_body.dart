import 'package:hermoso_store/cubit/register_cubit/register_cubit.dart';
import 'package:hermoso_store/data/local_data/shared_preferences.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/ui/screens/home/home_page.dart';
import 'package:hermoso_store/ui/widgets/custom_elevated_button.dart';
import 'package:hermoso_store/ui/widgets/row_text_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_form_field.dart';

class RegisterFormBody extends StatefulWidget {
  const RegisterFormBody({Key? key}) :super (key: key);

  @override
  _RegisterFormBodyState createState() => _RegisterFormBodyState();
}

class _RegisterFormBodyState extends State<RegisterFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String>? _authMode = {
    'email': '',
    'password': '',
    'confirm': '',
    'name': '',
    'phone': ''
  };

  bool _isPassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          final _prefs = await SharedPref.saveStringData(
              key: 'token', value: state.authModel.data?.token);
          print('token is : $_prefs');
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
        if (state is RegisterErrorState) {
          buildAlertsDialog(
              context, 'Something Went Error', state.error.toString());
          print('here is the error : ${state.error.toString}');
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                    suffixIcon: const Icon(Icons.person),
                    textInputType: TextInputType.name,
                    controller: _nameController,
                    validator: (value) {
                      if (value.isEmpty) return 'Invalid Name!';
                      return null;
                    },
                    onSaved: (value) {
                      _authMode?['name'] = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    suffixIcon: const Icon(Icons.mail_outlined),
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid Email !';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authMode?['email'] = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    labelText: 'Phone',
                    hintText: 'Enter Your Phone',
                    suffixIcon: const Icon(Icons.settings_cell_rounded),
                    textInputType: TextInputType.phone,
                    controller: _phoneController,
                    validator: (value) {
                      if (value.length != 11 || value.isEmpty) {
                        return 'phone is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authMode?['phone'] = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomFormField(
                    textInputType: TextInputType.visiblePassword,
                    obscureText: _isPassword ? false : true,
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    controller: _passwordController,
                    suffixIcon: IconButton(
                        icon: _isPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _isPassword = !_isPassword;
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
                  const SizedBox(height: 20),
                  CustomFormField(
                    textInputType: TextInputType.visiblePassword,
                    obscureText: _isPassword ? false : true,
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter Your Password',
                    controller: _confirmPassController,
                    suffixIcon: IconButton(
                        icon: _isPassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _isPassword = !_isPassword;
                          });
                        }),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Confirm Password is wrong!';
                      } else if (value != _passwordController.text) {
                        return 'confirm not equal to the password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authMode?['confirm'] = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(text: 'Sign Up', onPress: _registerNow),
                  RowTextAndButton(
                    title: 'Already had an Account?',
                    text: 'Sign IN',
                    onPressed: () =>
                        Navigator.of(context).pushNamed(LoginScreen.routeName),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _registerNow() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      RegisterCubit.get(context).userRegister(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
          _phoneController.text.trim());
      _formKey.currentState!.save();
    }
    _formKey.currentState!.save();
  }

  Future<bool> buildAlertsDialog(BuildContext context, title, message) async {
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titleTextStyle: const TextStyle(color: Colors.black),
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(onPressed: () {}, child: const Text('yes')),
                TextButton(onPressed: () {}, child: const Text('No')),
              ],
            ));
    return action;
  }
}
