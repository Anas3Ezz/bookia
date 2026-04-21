import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/networking/paymob_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymobService _paymobService;

  PaymentCubit(this._paymobService) : super(PaymentInitial());

  Future<void> initiatePayment({
    required double amount,
    required String firstName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentLoading());
    try {
      final url = await _paymobService.getPaymentUrl(
        amount: amount,
        firstName: firstName,
        email: email,
        phone: phone,
      );
      emit(PaymentUrlReady(url));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
