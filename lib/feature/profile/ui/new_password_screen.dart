import 'package:bookia/core/helper/validators.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class UpdateNewPasswordScreen extends StatelessWidget {
  const UpdateNewPasswordScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "New Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 40),

            // Password Fields
            CustomTextField(
              hintText: "New Password",
              controller: TextEditingController(),
              validator: AppValidators.password,
            ),
            const SizedBox(height: 20),
            //TODO: Add confirm password validation
            CustomTextField(
              hintText: "Confirm Password",
              controller: TextEditingController(),
              validator: AppValidators.password,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement password update logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB89F5D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Update Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
