part of 'settings_cubit.dart';

@immutable
abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}
class SettingsLoadingState extends SettingsStates {}
class SettingsSuccessState extends SettingsStates {
  final AuthModel authModel ;
  SettingsSuccessState(this.authModel);
}
class SettingsGetProfileLoadingState extends SettingsStates {}
class SettingsGetProfileSuccessState extends SettingsStates {
  final AuthModel authModel ;
  SettingsGetProfileSuccessState(this.authModel);
}
class SettingsUpdateProfileStateLoading extends SettingsStates {}
class SettingsUpdateProfileStateSuccess extends SettingsStates {
  final AuthModel authModel ;
  SettingsUpdateProfileStateSuccess(this.authModel);
}
class SettingsErrorState extends SettingsStates {
  final String error ;

  SettingsErrorState(this.error);
}

class SettingsChangeThemeModeState extends SettingsStates {}


