import 'package:bloc/bloc.dart';
import 'package:hermoso_store/model/auth_model/auth_model.dart';
import 'package:hermoso_store/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final UserRegisterRepository _userRegisterRepository = UserRegisterRepository();

  RegisterCubit() : super(const RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      String email, String password, String name, String phone) async {
    emit(const RegisterLoadingState());
    try {
      final registerRequest = await _userRegisterRepository.userRegister(
          email, password, name, phone);
      AuthModel authModel = AuthModel.fromJson(registerRequest.data);
      emit(RegisterSuccessState(authModel));
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
    }
  }
}
