import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/networking/paymob_service.dart';
import 'package:bookia/feature/payment/cubit/payment_cubit.dart';

class MockPaymobService extends Mock implements PaymobService {}

void main() {
  late MockPaymobService mockService;

  setUp(() {
    mockService = MockPaymobService();
  });

  group('PaymentCubit', () {
    const testUrl = 'https://accept.paymob.com/api/acceptance/iframes/123?payment_token=tok';

    blocTest<PaymentCubit, PaymentState>(
      'emits [PaymentLoading, PaymentUrlReady] when initiatePayment succeeds',
      build: () {
        when(() => mockService.getPaymentUrl(
              amount: any(named: 'amount'),
              firstName: any(named: 'firstName'),
              email: any(named: 'email'),
              phone: any(named: 'phone'),
            )).thenAnswer((_) async => testUrl);
        return PaymentCubit(mockService);
      },
      act: (cubit) => cubit.initiatePayment(
        amount: 150.0,
        firstName: 'Ahmed',
        email: 'ahmed@example.com',
        phone: '01012345678',
      ),
      expect: () => [
        isA<PaymentLoading>(),
        isA<PaymentUrlReady>(),
      ],
      verify: (_) {
        verify(() => mockService.getPaymentUrl(
              amount: 150.0,
              firstName: 'Ahmed',
              email: 'ahmed@example.com',
              phone: '01012345678',
            )).called(1);
      },
    );

    blocTest<PaymentCubit, PaymentState>(
      'PaymentUrlReady carries the returned URL',
      build: () {
        when(() => mockService.getPaymentUrl(
              amount: any(named: 'amount'),
              firstName: any(named: 'firstName'),
              email: any(named: 'email'),
              phone: any(named: 'phone'),
            )).thenAnswer((_) async => testUrl);
        return PaymentCubit(mockService);
      },
      act: (cubit) => cubit.initiatePayment(
        amount: 50.0,
        firstName: 'Sara',
        email: 'sara@example.com',
        phone: '01098765432',
      ),
      expect: () => [
        isA<PaymentLoading>(),
        isA<PaymentUrlReady>().having((s) => s.url, 'url', testUrl),
      ],
    );

    blocTest<PaymentCubit, PaymentState>(
      'emits [PaymentLoading, PaymentError] when initiatePayment throws',
      build: () {
        when(() => mockService.getPaymentUrl(
              amount: any(named: 'amount'),
              firstName: any(named: 'firstName'),
              email: any(named: 'email'),
              phone: any(named: 'phone'),
            )).thenThrow(Exception('Network failure'));
        return PaymentCubit(mockService);
      },
      act: (cubit) => cubit.initiatePayment(
        amount: 200.0,
        firstName: 'Omar',
        email: 'omar@example.com',
        phone: '01111111111',
      ),
      expect: () => [
        isA<PaymentLoading>(),
        isA<PaymentError>(),
      ],
    );

    blocTest<PaymentCubit, PaymentState>(
      'PaymentError carries the exception message',
      build: () {
        when(() => mockService.getPaymentUrl(
              amount: any(named: 'amount'),
              firstName: any(named: 'firstName'),
              email: any(named: 'email'),
              phone: any(named: 'phone'),
            )).thenThrow(Exception('Timeout'));
        return PaymentCubit(mockService);
      },
      act: (cubit) => cubit.initiatePayment(
        amount: 10.0,
        firstName: 'Test',
        email: 'test@example.com',
        phone: '00000000000',
      ),
      expect: () => [
        isA<PaymentLoading>(),
        isA<PaymentError>().having((s) => s.message, 'message', contains('Timeout')),
      ],
    );

    test('initial state is PaymentInitial', () {
      final cubit = PaymentCubit(mockService);
      expect(cubit.state, isA<PaymentInitial>());
      cubit.close();
    });
  });
}
