import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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

  bool isObscure = true;

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
                const Gap(20),
                Text(
                  'Welcome back! Glad to see you, Again!',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232C),
                  ),
                ),
                const Gap(32),
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
                const Gap(15),
                CustomTextField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      // 2. Toggle the state
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      // 3. Change icon based on state
                      isObscure
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off_rounded,
                      color: isObscure
                          ? Colors.grey
                          : AppColors
                                .primaryColor, // Optional: change color when active
                    ),
                  ),
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPassword: isObscure,
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
                    onPressed: () {
                      context.pushNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: const TextStyle(color: Color(0xFF6A707C)),
                    ),
                  ),
                ),
                const Gap(30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(title: Text('Error')),
                      );
                    } else if (state is AuthLoadingState) {
                      CircularProgressIndicator(color: AppColors.primaryColor);
                    } else if (state is AuthSuccess) {
                      context.pushNamedAndRemoveUntil(
                        AppRoutes.bottomNavBarScreen,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                    return AppButton(
                      text: 'Login',
                      isFilled: true,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().authLogin(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const Gap(20),
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
                const Gap(10),
                SocialLoginButton(
                  iconPath: 'assets/icons/google.png',
                  label: 'Google',
                  onTap: () {},
                ),
                const Gap(10),
                SocialLoginButton(
                  iconPath: 'assets/icons/apple.png',
                  label: 'Apple',
                  onTap: () {},
                ),
                const Gap(10),
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
