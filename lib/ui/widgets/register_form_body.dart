import 'package:hermoso_store/cubit/authUser/auth_users_cubit.dart';
import 'package:hermoso_store/ui/screens/auth_Screens/login_screen.dart';
import 'package:hermoso_store/ui/screens/home/home_page.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/loading_widget.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/password_icon.dart';
import 'package:hermoso_store/ui/widgets/custom_widgets/row_text_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/ui/widgets/show_dialog.dart';
import 'custom_widgets/custom_elevated_button.dart';
import 'custom_widgets/custom_form_field.dart';

class RegisterFormBody extends StatefulWidget {
  const RegisterFormBody({Key? key}) : super(key: key);

  @override
  _RegisterFormBodyState createState() => _RegisterFormBodyState();
}

class _RegisterFormBodyState extends State<RegisterFormBody>
    with ShowAlertMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String>? _authMode = {
    'email': '',
    'password': '',
    'confirm': '',
    'name': '',
    'phone': ''
  };

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthUsersCubit, AuthUserStates>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          if (state.authModel.status == true) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else {
            showMeDialog(context, state.authModel.message.toString(),
                'Enter the Valid Email');
          }
        }
        if (state is RegisterErrorState) {
          showMeDialog(
              context, state.error.toString(), 'Enter the Valid Email');
        }
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const LoadingWidget();
        }
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    CustomFormField(
                      labelText: 'Phone',
                      hintText: 'Enter Your Phone',
                      suffixIcon: const Icon(Icons.settings_cell_rounded),
                      textInputType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) {
                        if (value.length != 11 || value.isEmpty) {
                          return 'phone must be 11 No.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authMode?['phone'] = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      textInputType: TextInputType.visiblePassword,
                      obscureText:
                          _registerCubit().isPasswordRegistered ? false : true,
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      controller: _passwordController,
                      suffixIcon: PasswordIcon(
                          isPassword: _registerCubit().isPasswordRegistered,
                          onPressed: state is RegisterLoadingState
                              ? () {}
                              : () {
                                  _registerCubit().isPasswordRegistered =
                                      !_registerCubit().isPasswordRegistered;
                                  _registerCubit().changeRegisterPassword(
                                      _registerCubit().isPasswordRegistered);
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
                    const SizedBox(height: 16),
                    CustomFormField(
                      textInputType: TextInputType.visiblePassword,
                      obscureText: _registerCubit().isPasswordConfirmRegister
                          ? false
                          : true,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter Your Password',
                      controller: _confirmPassController,
                      suffixIcon: PasswordIcon(
                        isPassword: _registerCubit().isPasswordConfirmRegister,
                        onPressed: state is RegisterLoadingState
                            ? () {}
                            : () {
                                _registerCubit().isPasswordConfirmRegister =
                                    _registerCubit()
                                            .isPasswordConfirmRegister ==
                                        false;
                                _registerCubit().changeRegisterPassword(
                                    _registerCubit().isPasswordConfirmRegister);
                              },
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Wrong or less than 6 Letter!';
                        } else if (value != _passwordController.text) {
                          return 'confirm not equal to the password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authMode?['confirm'] = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (state is RegisterLoadingState)
                      const Center(child: CircularProgressIndicator()),
                    CustomElevatedButton(
                        text: 'Sign Up',
                        onPress: state is RegisterLoadingState
                            ? null
                            : _registerUser),
                    RowTextAndButton(
                      title: 'Already had an Account?',
                      text: 'Sign IN',
                      onPressed: state is RegisterLoadingState
                          ? () {}
                          : () => Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _registerCubit().userRegister(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
          _phoneController.text.trim());
      _formKey.currentState?.save();
    }
    _formKey.currentState?.save();
  }

  AuthUsersCubit _registerCubit() => BlocProvider.of<AuthUsersCubit>(context);
}
