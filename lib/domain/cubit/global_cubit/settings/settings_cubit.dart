import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/database/local_data/shared_preferences.dart';
import '../../../../data/model/auth_model/auth_model.dart';
import '../../../../utils/constants.dart';
import '../../../repository/settings_repository.dart';


part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

 final SettingsRepository _settingsRepository = MockSettingsRepo();


  AuthModel authModel = AuthModel();

  bool isDarkMode = false;
  String dropDownValue = 'English';

  void switchThemeMode({bool? themeMode}) {
    themeMode != null? isDarkMode = themeMode : isDarkMode = !isDarkMode;
    SharedPref.saveData(key: 'dark', value: isDarkMode);
    emit(SettingsChangeThemeModeState());
  }

  void changeLanguage(String? value) async{
    dropDownValue = value!;
    emit(SettingsChangeLanguageState());
  }

  void updateUserProfile(
      {required String name,
      required String email,
      required String phone}) async {
    emit(SettingsUpdateProfileStateLoading());
    try {
      authModel = await _settingsRepository.updateProfile(name, email, phone);
      print('cubit settings status ${authModel.message}');
      emit(SettingsUpdateProfileStateSuccess(authModel));
    } catch (error) {
      print('cubit settings error updateUser ${error.toString()}');
      emit(SettingsErrorState(error.toString()));
    }
  }

  void getUserProfile() async {
    emit(SettingsGetProfileLoadingState());
    if (AppStrings.token != null) {
      try {
        authModel = await _settingsRepository.getProfile();
        print('getUserProfile cubit settings status ${authModel.status}');
        emit(SettingsGetProfileSuccessState(authModel));
      } on SocketException {
        throw Exception('Response Error');
      } catch (error) {
        print('settings cubit getUserProfile error : ${error.toString()}');
        emit(SettingsErrorState(error.toString()));
      }
    }
  }

  Future<void> logOutSettings() async {
    emit(SettingsLoadingState());
    try {
      authModel.message = await _settingsRepository.loginOut();
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
