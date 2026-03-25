import 'package:bloc/bloc.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> authLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await AuthRepo.login(email: email, password: password);
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccessState()),
      failure: (error) => emit(AuthErrorState(message: error)),
    );
  }

  Future<void> authRegister({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
  }) async {
    emit(AuthLoadingState());
    final result = await AuthRepo.register(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      name: name,
    );
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccessState()),
      failure: (error) => emit(AuthErrorState(message: error)),
    );
  }
}
