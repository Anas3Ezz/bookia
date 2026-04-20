import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isResending = false;

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (_pinController.text.length == 6) {
      context.pushNamed(AppRoutes.createNewPasswordScreen);
    }
  }

  // 2. Extract the resend logic into a dedicated async method
  Future<void> _onResend() async {
    if (_isResending) return; // Prevent multiple taps

    setState(() {
      _isResending = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appColors.borderColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryColor),
        color: context.appColors.background,
      ),
    );

    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),
              const CustomBackButton(),
              Gap(32.h),
              Text(
                'OTP Verification',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              Gap(12.h),
              Text(
                'Enter the verification code we just sent on\nyour email address.',
                style: TextStyle(fontSize: 14.sp, height: 1.5),
              ),
              Gap(40.h),
              Center(
                child: Pinput(
                  length: 6,
                  controller: _pinController,
                  focusNode: _focusNode,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  separatorBuilder: (_) => SizedBox(width: 8.w),
                  onCompleted: (_) => _onVerify(),
                ),
              ),
              Gap(32.h),
              AppButton(
                text: 'Verify',
                onPressed: _onVerify,
                isFilled: true,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
              ),
              const Spacer(),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn't received code? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: _isResending ? null : _onResend,
                      child: Container(
                        color: Colors.transparent,
                        child: _isResending
                            ? SizedBox(
                                width: 16.sp,
                                height: 16.sp,
                                child: const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Resend',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
