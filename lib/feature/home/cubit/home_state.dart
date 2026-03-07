part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GethomeSliderLoading extends HomeState {}

final class GethomeSliderSucess extends HomeState {
  final List<SliderImages> sliders;

  GethomeSliderSucess(this.sliders);
}

final class GethomeSliderError extends HomeState {}

final class BestSellerLoading extends HomeState {}

final class BestSellerSucess extends HomeState {
  final List<Products> books;

  BestSellerSucess(this.books);
}

final class BestSellerError extends HomeState {}
