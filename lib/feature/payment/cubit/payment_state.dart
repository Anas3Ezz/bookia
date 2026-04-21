part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentUrlReady extends PaymentState {
  final String url;
  PaymentUrlReady(this.url);
}

class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);
}
