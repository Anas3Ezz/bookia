part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

// ─── Slider States ───────────────────────────────────────

abstract class GetHomeSliderState extends HomeState {}

final class GetHomeSliderLoading extends GetHomeSliderState {}

final class GetHomeSliderSuccess extends GetHomeSliderState {
  final List<SliderImages> sliders;

  GetHomeSliderSuccess(this.sliders);
}

final class GetHomeSliderError extends GetHomeSliderState {
  final String message;

  GetHomeSliderError({this.message = 'Failed to load sliders'});
}

// ─── Best Seller States ──────────────────────────────────

abstract class BestSellerState extends HomeState {}

final class BestSellerLoading extends BestSellerState {}

final class BestSellerSuccess extends BestSellerState {
  final List<Products> books;

  BestSellerSuccess(this.books);
}

final class BestSellerError extends BestSellerState {
  final String message;

  BestSellerError({this.message = 'Failed to load best sellers'});
}
