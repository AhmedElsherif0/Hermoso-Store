import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermoso_store/repository/settings_repository.dart';
import 'package:meta/meta.dart';

import '../../../data/local_data/shared_preferences.dart';
import '../../../model/auth_model/auth_model.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  SettingsRepository settingsRepository = MockSettingsRepo();

  static SettingsCubit get(context) => BlocProvider.of(context);

  AuthModel authModel = AuthModel();

  bool isDarkMode = false;

  void switchThemeMode({getShared}) {
    if (getShared != null) {
      isDarkMode = getShared;
      emit(SettingsChangeThemeModeState());
    } else {
      isDarkMode = !isDarkMode;
      SharedPref.saveData(key: 'dark', value: isDarkMode);
      emit(SettingsChangeThemeModeState());
    }
  }

  void updateUserProfile(String name, String email, String phone) async {
    emit(SettingsUpdateProfileStateLoading());
    try {
      authModel = await settingsRepository.updateProfile(name, email, phone);
      print('cubit settings status ${authModel.message}');
      if (authModel.status = true) {
        authModel.data.name = name;
        authModel.data.email = email;
        authModel.data.phone = phone;
      }
      emit(SettingsUpdateProfileStateSuccess(authModel));
    } catch (error) {
      print('cubit settings error updateUser ${error.toString()}');
      emit(SettingsErrorState(error.toString()));
    }
  }

  void getUserProfile() async {
    emit(SettingsGetProfileLoadingState());
    try {
      authModel = await settingsRepository.getProfile();
      print('cubit settings status ${authModel.status}');
      emit(SettingsGetProfileSuccessState(authModel));
    } on SocketException {
      throw Exception('Response Error');
    } catch (error) {
      print('settings cubit error : ${error.toString()}');
      emit(SettingsErrorState(error.toString()));
    }
  }

  void logOutSettings() async {
    emit(SettingsLoadingState());
    try {
      authModel = await settingsRepository.loginOut();
      print('cubit settings status ${authModel.message}');
      emit(SettingsSuccessState(authModel));
    } on SocketException {
      throw Exception('Response Error');
    } catch (error) {
      print('settings cubit error : ${error.toString()}');
      emit(SettingsErrorState(error.toString()));
    }
  }
}
