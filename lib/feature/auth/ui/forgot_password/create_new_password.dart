import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/helper/validators.dart';
import '../../../../core/theme/app_theme.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onResetPassword() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          context.pushNamed(AppRoutes.passwordChangedSuccess);
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
    // if (_formKey.currentState?.validate() ?? false) {
    //   context.pushNamedAndRemoveUntil(AppRoutes.passwordChangedSuccess);
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                'Create new password',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              Gap(12.h),
              Text(
                'Your new password must be unique from those\npreviously used.',
                style: TextStyle(fontSize: 14.sp, height: 1.5),
              ),
              Gap(32.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'New Password',
                      controller: _newPasswordController,
                      isPassword: !_showNewPassword,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.newPassword],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showNewPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                          () => _showNewPassword = !_showNewPassword,
                        ),
                      ),
                      validator: AppValidators.password,
                    ),
                    Gap(16.h),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      isPassword: !_showConfirmPassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(
                          () => _showConfirmPassword = !_showConfirmPassword,
                        ),
                      ),
                      //TOD:O: add confirm password validation
                      validator: AppValidators.password,
                    ),
                  ],
                ),
              ),
              Gap(24.h),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : AppButton(
                      text: 'Reset Password',
                      onPressed: _onResetPassword,
                      isFilled: true,
                      backgroundColor: const Color(0xFFBB9457),
                      textColor: Colors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
