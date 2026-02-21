import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 5,
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
                'Hello! Register to get started',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232C),
                ),
              ),
              const SizedBox(height: 32),
              const CustomTextField(hintText: 'User name'),
              const SizedBox(height: 15),

              const CustomTextField(hintText: 'Email'),
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: 'Enter your password',
                isPassword: true,
              ),
              const SizedBox(height: 15),

              const CustomTextField(
                hintText: 'Confirm your password',
                isPassword: true,
              ),

              const SizedBox(height: 30),
              AppButton(text: 'Register', isFilled: true, onPressed: () {}),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?  "),
                  Text('Login Now', style: TextStyle(color: Color(0xFFBB9457))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
