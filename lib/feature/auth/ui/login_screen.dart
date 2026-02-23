import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/extenstions.dart';
import '../../../core/routs/app_routs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
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
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    // Professional Regex for email validation
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+",
                    ).hasMatch(value);
                    if (!emailValid) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) return 'Password too short';
                    return null;
                  },
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
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthErrorState) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(title: Text('Error')),
                      );
                    } else if (state is AuthLoadingState) {
                      CircularProgressIndicator(color: AppColors.primaryColor);
                    } else if (state is AuthSucessState) {
                      context.pushNamed(AppRoutes.home);
                    }
                  },
                  child: AppButton(
                    text: 'login',
                    isFilled: true,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().authLogin(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                  ),
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
      ),
    );
  }
}
