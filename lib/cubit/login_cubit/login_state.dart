part of 'login_cubit.dart';

@immutable
abstract class LoginStates {
  const LoginStates();
}

class LoginInitialState extends LoginStates {
  const LoginInitialState();

}

class LoginSuccessState extends LoginStates {
  final AuthModel authModel ;
  const LoginSuccessState(this.authModel);
}

class LoginLoadingState extends LoginStates {
  const LoginLoadingState();

}
class LoginChangeState extends LoginStates {
  const LoginChangeState();

}

class LoginErrorState extends LoginStates {
  final String error;

 const LoginErrorState(this.error);
}
