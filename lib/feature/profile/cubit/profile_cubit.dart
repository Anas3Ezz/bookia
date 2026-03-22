import 'package:bloc/bloc.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/profile/data/model/profile_model.dart';
import 'package:bookia/feature/profile/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final response = await ProfileRepo.getProfile();
    if (isClosed) return;

    response == null
        ? emit(GetProfileError())
        : emit(GetProfileSuccess(response.data ?? ProfileData()));
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await AuthRepo.logout();
      if (isClosed) return;
      emit(LogoutSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(LogoutError());
    }
  }
}
