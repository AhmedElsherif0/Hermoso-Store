import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/auth_model/auth_model.dart';
import '../../repository/auth_user_repository.dart';

part 'auth_users_state.dart';

class AuthUsersCubit extends Cubit<AuthUserStates> {
  AuthUsersCubit() : super(const AuthUserInitialState());
  final AuthUserRepository _authUserRepo = MockAuthUserRepo();

  static AuthUsersCubit get(context) => BlocProvider.of(context);

  AuthModel authModel = AuthModel();


  Future<AuthModel> userLogin(String email, String password) async {
    emit(LoginLoadingState());
    try {
      authModel = await _authUserRepo.userLogin(email, password);
      emit(LoginSuccessState(authModel));
    } catch (error) {
      print('cubit login error = ${authModel.status}');
      emit(LoginErrorState(error.toString()));
    }
    return  authModel;
  }

  Future<AuthModel> userRegister(
      String email, String password, String name, String phone) async {
    emit(RegisterLoadingState());
    try {
      authModel = await _authUserRepo.userRegister(
          email, password, name, phone);
      emit(RegisterSuccessState(authModel));
    } on SocketException {
      throw Exception('Response Error');
    }catch (error) {
      emit(RegisterErrorState(error.toString()));
    }
    return authModel ;
  }


  bool isPasswordRegistered = false;
  bool isPasswordConfirmRegister = false;
  bool isPasswordLogin = false;


  void changeLoginPassword(bool isPassword) {
    emit(LoginChangeState());
    print('changePassword$isPassword') ;
  }

  void changeRegisterPassword(bool isPassword) {
      emit(RegisterChangeState());
    print('changePassword$isPassword') ;
  }

}
