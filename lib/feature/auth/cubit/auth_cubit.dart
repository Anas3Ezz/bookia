import 'package:bloc/bloc.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepo _authRepository = AuthRepo.instance;

  // ── Email Sign In ────────────────────────────────────────────────────────────

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess('Signed in successfully! 👋'));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(AuthRepo.getErrorMessage(e)));
    }
  }

  // ── Register ─────────────────────────────────────────────────────────────────

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      final credential = await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      await credential.user?.updateDisplayName(name.trim());
      emit(AuthSuccess('Welcome, ${name.trim()}! 🎉'));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(AuthRepo.getErrorMessage(e)));
    }
  }

  // ── Google Sign In ───────────────────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    emit(AuthGoogleLoading());
    try {
      final credential = await _authRepository.signInWithGoogle();

      // User cancelled the Google picker
      if (credential == null) {
        emit(AuthInitial());
        return;
      }

      emit(
        AuthSuccess('Welcome, ${credential.user?.displayName ?? 'User'}! 🎉'),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(AuthRepo.getErrorMessage(e)));
    } catch (_) {
      emit(AuthFailure('Google sign-in failed. Please try again.'));
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────────

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(AuthSuccess('Reset email sent! Check your inbox.'));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(AuthRepo.getErrorMessage(e)));
    }
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthInitial());
  }

  // ── Reset state ───────────────────────────────────────────────────────────────

  void reset() => emit(AuthInitial());
  Future<void> authLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await AuthRepo.login(email: email, password: password);
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Signed in successfully! 👋')),
      failure: (error) => emit(
        AuthFailure(AuthRepo.getErrorMessage(error as FirebaseAuthException)),
      ),
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
      success: (_) => emit(AuthSuccess('Welcome, ${name.trim()}! 🎉')),
      failure: (error) => emit(
        AuthFailure(AuthRepo.getErrorMessage(error as FirebaseAuthException)),
      ),
    );
  }
}
