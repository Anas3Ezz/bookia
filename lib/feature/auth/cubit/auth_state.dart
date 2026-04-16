part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthGoogleLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
