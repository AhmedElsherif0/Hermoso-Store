part of 'auth_users_cubit.dart';

@immutable
abstract class AuthUserStates {
  const AuthUserStates();
}

class AuthUserInitialState extends AuthUserStates {
  const AuthUserInitialState();
}

class LoginLoadingState extends AuthUserStates {}

class LoginSuccessState extends AuthUserStates {
  final AuthModel authModel;

  const LoginSuccessState(this.authModel);
}

class LoginChangeState extends AuthUserStates {}

class LoginErrorState extends AuthUserStates {
  final String error;

  const LoginErrorState(this.error);
}

class RegisterInitialState extends AuthUserStates {}

class RegisterLoadingState extends AuthUserStates {}

class RegisterSuccessState extends AuthUserStates {
  final AuthModel authModel;

  const RegisterSuccessState(this.authModel);
}
class RegisterChangeState extends AuthUserStates {}


class RegisterErrorState extends AuthUserStates {
  final String error;

  const RegisterErrorState(this.error);
}
