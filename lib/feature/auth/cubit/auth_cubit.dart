import 'package:bloc/bloc.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void authLogin({required String email, required String password}) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.login(email: email, password: password);
    if (response) {
      emit(AuthSucessState());
    } else {
      emit(AuthErrorState());
    }
  }

  void authRegister({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.register(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      name: name,
    );
    if (response) {
      emit(AuthSucessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
