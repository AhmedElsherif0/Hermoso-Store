import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/auth_model/auth_model.dart';
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
    return authModel;
  }

  Future<AuthModel> userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(RegisterLoadingState());
    try {
      authModel =
          await _authUserRepo.userRegister(email, password, name, phone);
      print('cubit Register ${authModel.message.toString()}');
      emit(RegisterSuccessState(authModel));
    } on SocketException {
      throw Exception('Response Error');
    } catch (error) {
      print('cubit Register Error${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    }
    return authModel;
  }

  bool isPasswordRegistered = false;
  bool isPasswordConfirmRegister = false;
  bool isPasswordLogin = false;

  void changeLoginPassword(bool isPassword) {
    emit(LoginChangeState());
    print('changePassword$isPassword');
  }

  void changeRegisterPassword(bool isPassword) {
    emit(RegisterChangeState());
    print('changePassword$isPassword');
  }
}
