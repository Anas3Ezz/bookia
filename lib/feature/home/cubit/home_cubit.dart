import 'package:bloc/bloc.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';
import 'package:bookia/feature/home/data/repo/home_slider_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeSliders() async {
    emit(GetHomeSliderLoading());
    final (response, error) = await HomeRepo.getHomeSliders();
    if (isClosed) return;

    response == null
        ? emit(GetHomeSliderError(message: error ?? 'Failed to load sliders.'))
        : emit(GetHomeSliderSuccess(response.data?.sliders ?? []));
  }

  Future<void> getBestSellerBooks() async {
    emit(BestSellerLoading());
    final (response, error) = await HomeRepo.getBestSellerBooks();
    if (isClosed) return;

    response == null
        ? emit(
            BestSellerError(message: error ?? 'Failed to load best sellers.'),
          )
        : emit(BestSellerSuccess(response.data?.products ?? []));
  }

  Future<void> getHomeData() async {
    await Future.wait([getHomeSliders(), getBestSellerBooks()]);
  }
}
