part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

// ─── Get Profile ─────────────────────────────
abstract class GetProfileState extends ProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final ProfileData profile;
  GetProfileSuccess(this.profile);
}

final class GetProfileError extends GetProfileState {
  final String message;
  GetProfileError({this.message = 'Failed to load profile'});
}

// ─── Logout ──────────────────────────────────
abstract class LogoutState extends ProfileState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutError extends LogoutState {
  final String message;
  LogoutError({this.message = 'Failed to logout. Please try again.'});
}
