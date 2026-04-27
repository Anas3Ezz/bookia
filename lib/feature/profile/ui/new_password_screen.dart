import 'package:bookia/core/helper/validators.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class UpdateNewPasswordScreen extends StatefulWidget {
  const UpdateNewPasswordScreen({super.key});

  @override
  State<UpdateNewPasswordScreen> createState() =>
      _UpdateNewPasswordScreenState();
}

class _UpdateNewPasswordScreenState extends State<UpdateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: AppBar(
        backgroundColor: context.appColors.background,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "New Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: context.appColors.textPrimary,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                hintText: "New Password",
                controller: _passwordController,
                isPassword: true,
                validator: AppValidators.password,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: "Confirm Password",
                controller: _confirmPasswordController,
                isPassword: true,
                validator: (value) => AppValidators.confirmPassword(
                  value,
                  _passwordController.text,
                ),
              ),
              const Spacer(),
              AppButton(
                text: "Update Password",
                onPressed: () {},
                isFilled: true,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
