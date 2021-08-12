part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {
  const RegisterStates();
}

class RegisterInitialState extends RegisterStates {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterStates {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterStates {
  final AuthModel authModel ;
  const RegisterSuccessState(this.authModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  const RegisterErrorState(this.error);
}
