import 'package:bloc/bloc.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';
import 'package:bookia/feature/home/data/repo/home_slider_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeSliders() async {
    emit(GethomeSliderLoading());
    final response = await HomeRepo.gethomeSliders();
    if (response is SliderModel) {
      emit(GethomeSliderSucess(response.data?.sliders ?? []));
    } else {
      emit(GethomeSliderError());
    }
  }

  Future<void> getBestSellerBooks() async {
    emit(BestSellerLoading());
    final response = await HomeRepo.getBestSellerBooks();
    if (response is BooksModel) {
      emit(BestSellerSucess(response.data?.products ?? []));
    } else {
      emit(BestSellerError());
    }
  }

  Future<void> getHomeData() async {
    await Future.wait([getHomeSliders(), getBestSellerBooks()]);
  }
}
