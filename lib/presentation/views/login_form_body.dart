import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/presentation/widgets/show_dialog.dart';
import '../../cubit/authUser/auth_users_cubit.dart';
import '../screens/auth_Screens/forget_password.dart';
import '../screens/auth_Screens/register_screen.dart';
import '../screens/home/home_page.dart';

import 'package:flutter/material.dart';

import '../widgets/custom_widgets/custom_elevated_button.dart';
import '../widgets/custom_widgets/custom_form_field.dart';
import '../widgets/custom_widgets/custom_outline_button.dart';
import '../widgets/custom_widgets/custom_text_button.dart';
import '../widgets/custom_widgets/loading_widget.dart';
import '../widgets/custom_widgets/password_icon.dart';
import '../widgets/custom_widgets/row_text_and_button.dart';


class LoginFormBody extends StatefulWidget {
  const LoginFormBody({Key? key}) : super(key: key);

  @override
  _LoginFormBodyState createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> with ShowAlertMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String>? _authMode = {'email': '', 'password': ''};
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthModel? authModel;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: BlocConsumer<AuthUsersCubit, AuthUserStates>(
            listener: (context, state) async {
          if (state is LoginSuccessState) {
            if (state.authModel.status == true) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            } else {
              showMeAlertDialog(context, state.authModel.message);
            }
          }
          if (state is LoginErrorState) {
            print(state.error.toString());
            //    showMeAlertDialog(context, state.error.toString());
          }
        }, builder: (context, state) {
          if (state is LoginLoadingState) {
            return const LoadingWidget();
          } else {
            return Form(
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
                        obscureText:
                            _loginCubit().isPasswordLogin ? false : true,
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        controller: _passwordController,
                        suffixIcon: PasswordIcon(
                            isPassword: _loginCubit().isPasswordLogin,
                            onPressed: state is LoginLoadingState
                                ? () {}
                                : () {
                                    _loginCubit().isPasswordLogin =
                                        !_loginCubit().isPasswordLogin;
                                    _loginCubit().changeLoginPassword(
                                        _loginCubit().isPasswordLogin);
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
                        onPressed: state is LoginLoadingState
                            ? () {}
                            : () => Navigator.pushNamed(
                                context, ForgetPassword.routeName),
                      ),
                      if (state is LoginLoadingState)
                        const Center(child: CircularProgressIndicator()),
                      CustomElevatedButton(
                          text: 'Login',
                          onPress:
                              state is LoginLoadingState ? null : _onLogin),
                      const SizedBox(height: 10),
                      RowTextAndButton(
                        title: 'Don\'t have an Account?',
                        text: 'Sign UP',
                        onPressed: state is LoginLoadingState
                            ? () {}
                            : () => Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName),
                      ),
                    ],
                  ),
                );
          }
        }),
      ),
    );
  }

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _loginCubit().userLogin(
          _emailController.text.trim(),
          _passwordController.text.trim());
      _formKey.currentState?.save();
    }
    _formKey.currentState?.save();
  }

  void showMeAlertDialog(BuildContext context, state) {
    showAlertDialog(
      context: context,
      title: state,
      actionButton: [
        CustomOutlineButton(
          onPressed: () => Navigator.pop(context),
          text: 'Close',
        )
      ],
    );
  }

  AuthUsersCubit _loginCubit() => BlocProvider.of<AuthUsersCubit>(context);
}
