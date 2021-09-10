import 'package:bloc/bloc.dart';
import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:hermoso_store/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(const LoginInitialState());
  final UserLoginRepository _userLoginRepo = UserLoginRepository();

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin(String email, String password) async {
    emit(const LoginLoadingState());
    try {
      final loginResponse = await _userLoginRepo.userLogin(email, password);
      AuthModel authModel = AuthModel.fromJson(loginResponse.data);
      emit(LoginSuccessState(authModel));
    } catch (error) {
      emit(LoginErrorState('Error State Login Cubit : ${error.toString()}'));
    }
  }

  IconData suffix = Icons.visibility_outlined;

  void changePassword(bool isPassword) {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(const LoginChangeState());
  }
}
