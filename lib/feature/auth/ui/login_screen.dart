import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:bookia/feature/auth/ui/widgets/social_login_button.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/extenstions.dart';
import '../../../core/routs/app_routs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 7,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8ECF4)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome back! Glad to see you, Again!',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232C),
                ),
              ),
              const SizedBox(height: 32),
              const CustomTextField(hintText: 'Enter your email'),
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: 'Enter your password',
                isPassword: true,
                suffixIcon: Icon(
                  Icons.visibility_outlined,
                  color: Color(0xFF8391A1),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: const TextStyle(color: Color(0xFF6A707C)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AppButton(
                text: 'login',
                isFilled: true,
                onPressed: () {
                  // login();
                },
              ),
              const SizedBox(height: 35),
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE8ECF4))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Or'),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE8ECF4))),
                ],
              ),
              const SizedBox(height: 20),
              SocialLoginButton(
                iconPath: 'assets/icons/google.png',
                label: 'Google',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                iconPath: 'assets/icons/apple.png',
                label: 'Apple',
                onTap: () {},
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?  "),
                  InkWell(
                    onTap: () => context.pushNamed(AppRoutes.register),
                    child: Text(
                      'Register Now',
                      style: TextStyle(color: Color(0xFFBB9457)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
