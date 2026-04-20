import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/helper/validators.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'payment_widgets/card_preview.dart';
import 'payment_widgets/field_label.dart';
import 'payment_widgets/payment_bottom_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.total});

  final String total;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _isFlipped = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onPay() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: wire to payment cubit
      Future.delayed(const Duration(seconds: 1), () {
        // Simulate payment processing delay
        if (mounted) {
          context.pushNamed(AppRoutes.congrates);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16.h),
                      const CustomBackButton(),
                      Gap(24.h),
                      Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: context.appColors.textPrimary,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        'Enter your card details to complete the order.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.appColors.subtitle,
                          height: 1.5,
                        ),
                      ),
                      Gap(32.h),
                      CardPreview(
                        cardNumber: _cardNumberController.text,
                        cardHolder: _cardHolderController.text,
                        expiry: _expiryController.text,
                        cvv: _cvvController.text,
                        isFlipped: _isFlipped,
                      ),
                      Gap(32.h),
                      const FieldLabel(label: 'Card Number'),
                      Gap(8.h),
                      CustomTextField(
                        hintText: '1234  5678  9012  3456',
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _CardNumberFormatter(),
                          LengthLimitingTextInputFormatter(19),
                        ],
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          final digits = value?.replaceAll(' ', '') ?? '';
                          if (digits.isEmpty) return 'Card number is required';
                          if (digits.length < 16) {
                            return 'Enter a valid 16-digit card number';
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),
                      const FieldLabel(label: 'Card Holder Name'),
                      Gap(8.h),
                      CustomTextField(
                        hintText: 'Name on card',
                        controller: _cardHolderController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (_) => setState(() {}),
                        validator: AppValidators.name,
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FieldLabel(label: 'Expiry Date'),
                                Gap(8.h),
                                CustomTextField(
                                  hintText: 'MM/YY',
                                  controller: _expiryController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    _ExpiryFormatter(),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  onChanged: (_) => setState(() {}),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    if (value.length < 5) return 'Invalid date';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FieldLabel(label: 'CVV'),
                                Gap(8.h),
                                CustomTextField(
                                  hintText: '• • •',
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  isPassword: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onFocusChanged: (hasFocus) =>
                                      setState(() => _isFlipped = hasFocus),
                                  onChanged: (_) => setState(() {}),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    if (value.length < 3) return 'Invalid CVV';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(32.h),
                    ],
                  ),
                ),
              ),
            ),
            PaymentBottomBar(total: widget.total, onPay: _onPay),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Input Formatters — stay here, they are
// private implementation details of this screen
// ─────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
