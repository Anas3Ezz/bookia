import 'package:bloc/bloc.dart';
import 'package:bookia/core/networking/api_result.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/auth/data/repo/firebase_auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuthRepo _firebaseAuthRepo = FirebaseAuthRepo.instance;

  // ── API Login ─────────────────────────────────────────────────────────────────

  Future<void> authLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await AuthRepo.login(email: email, password: password);
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Signed in successfully! 👋')),
      failure: (error) => emit(AuthFailure(error)), // error is already a String
    );
  }

  // ── API Register ──────────────────────────────────────────────────────────────

  Future<void> authRegister({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoadingState());
    final result = await AuthRepo.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Welcome, ${name.trim()}! 🎉')),
      failure: (error) => emit(AuthFailure(error)), // error is already a String
    );
  }

  // ── Firebase Email Sign In ────────────────────────────────────────────────────

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await _firebaseAuthRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Signed in successfully! 👋')),
      failure: (error) => emit(AuthFailure(error)),
    );
  }

  // ── Firebase Register ─────────────────────────────────────────────────────────

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final result = await _firebaseAuthRepo.createUserWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Welcome, ${name.trim()}! 🎉')),
      failure: (error) => emit(AuthFailure(error)),
    );
  }

  // ── Google Sign In ────────────────────────────────────────────────────────────

  Future<void> signInWithGoogle() async {
    emit(AuthGoogleLoading());
    final result = await _firebaseAuthRepo.signInWithGoogle();
    if (isClosed) return;

    result.when(
      success: (credential) {
        // null means user cancelled the picker — not an error
        if (credential == null) {
          emit(AuthInitial());
          return;
        }
        final name = credential.user?.displayName ?? 'User';
        emit(AuthSuccess('Welcome, $name! 🎉'));
      },
      failure: (error) => emit(AuthFailure(error)),
    );
  }

  // ── Forgot Password ───────────────────────────────────────────────────────────

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(AuthLoadingState());
    final result = await _firebaseAuthRepo.sendPasswordResetEmail(email: email);
    if (isClosed) return;

    result.when(
      success: (_) => emit(AuthSuccess('Reset email sent! Check your inbox.')),
      failure: (error) => emit(AuthFailure(error)),
    );
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await _firebaseAuthRepo.signOut();
    if (isClosed) return;
    emit(AuthInitial());
  }

  // ── Reset ─────────────────────────────────────────────────────────────────────

  void reset() => emit(AuthInitial());
}
