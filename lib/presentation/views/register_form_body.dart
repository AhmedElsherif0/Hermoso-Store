import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_elevated_button.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/custom_form_field.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/loading_widget.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/password_icon.dart';
import 'package:hermoso_store/presentation/widgets/custom_widgets/row_text_and_button.dart';
import 'package:hermoso_store/presentation/widgets/show_dialog.dart';
import 'package:sizer/sizer.dart';
import '../../domain/cubit/authUser/auth_users_cubit.dart';
import '../screens/auth_Screens/login_screen.dart';
import '../screens/home/home_screen.dart';
import 'auth_integrations_buttons.dart';

class RegisterFormBody extends StatefulWidget {
  const RegisterFormBody({Key? key}) : super(key: key);

  @override
  _RegisterFormBodyState createState() => _RegisterFormBodyState();
}

class _RegisterFormBodyState extends State<RegisterFormBody>
    with AlertDialogMixin {
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
            showAlertDialog(context, state.authModel.message.toString(),
                'Enter the Valid Email');
          }
        }
        if (state is RegisterErrorState) {
          showAlertDialog(
              context, state.error.toString(), 'Enter the Valid Email');
        }
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const LoadingWidget();
        }
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 0.5.h),
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
                    SizedBox(height: 2.h),
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
                    SizedBox(height: 2.h),
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
                    SizedBox(height: 2.h),
                    CustomFormField(
                      textInputType: TextInputType.visiblePassword,
                      obscureText:
                          _registerCubit().isPasswordRegistered ? false : true,
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      controller: _passwordController,
                      onPressIcon: state is RegisterLoadingState
                          ? () {}
                          : () {
                              _registerCubit().isPasswordRegistered =
                                  !_registerCubit().isPasswordRegistered;
                              _registerCubit().changeRegisterPassword(
                                  _registerCubit().isPasswordRegistered);
                            },
                      suffixIcon: PasswordIcon(
                        isPassword: _registerCubit().isPasswordRegistered,
                      ),
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
                    SizedBox(height: 2.h),
                    CustomFormField(
                      textInputType: TextInputType.visiblePassword,
                      obscureText: _registerCubit().isPasswordConfirmRegister
                          ? false
                          : true,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter Your Password',
                      controller: _confirmPassController,
                      onPressIcon: state is RegisterLoadingState
                          ? () {}
                          : () {
                              _registerCubit().isPasswordConfirmRegister =
                                  _registerCubit().isPasswordConfirmRegister ==
                                      false;
                              _registerCubit().changeRegisterPassword(
                                  _registerCubit().isPasswordConfirmRegister);
                            },
                      suffixIcon: PasswordIcon(
                        isPassword: _registerCubit().isPasswordConfirmRegister,
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
                    SizedBox(height: 2.h),
                    if (state is RegisterLoadingState)
                      const Center(child: CircularProgressIndicator()),
                    CustomElevatedButton(
                        text: 'Sign Up',
                        onPressed: state is RegisterLoadingState
                            ? null
                            : _registerUser),
                    SizedBox(height: 1.h),
                    RowTextAndButton(
                      title: 'Already had an Account?',
                      text: 'Sign IN',
                      onPressed: state is RegisterLoadingState
                          ? () {}
                          : () => Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName),
                    ),
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
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim());
      _formKey.currentState?.save();
    }
    _formKey.currentState?.save();
  }

  AuthUsersCubit _registerCubit() => BlocProvider.of<AuthUsersCubit>(context);
}
