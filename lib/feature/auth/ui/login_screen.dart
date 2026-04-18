import 'package:bookia/core/helper/validators.dart';
import 'package:bookia/core/theme/app_theme.dart';
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
  bool isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Text(
                  'Welcome back! Glad to see you, Again!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                const Gap(32),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  validator: AppValidators.email,
                ),
                const Gap(15),
                CustomTextField(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => isObscure = !isObscure),
                    icon: Icon(
                      isObscure
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off_rounded,
                      color: isObscure ? Colors.grey : AppColors.primaryColor,
                    ),
                  ),
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  isPassword: isObscure,
                  textInputAction: TextInputAction.done,
                  validator: AppValidators.password,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        context.pushNamed(AppRoutes.forgotPasswordScreen),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: context.appColors.subtitle),
                    ),
                  ),
                ),
                const Gap(30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      context.pushNamedAndRemoveUntil(
                        AppRoutes.bottomNavBarScreen,
                      );
                    } else if (state is AuthFailure) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    // Both email login and Google show a loader
                    if (state is AuthLoadingState ||
                        state is AuthGoogleLoading) {
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
                    Expanded(
                      child: Divider(color: context.appColors.borderColor),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or'),
                    ),
                    Expanded(
                      child: Divider(color: context.appColors.borderColor),
                    ),
                  ],
                ),
                const Gap(10),
                // ── Google Sign In ────────────────────────────────────────────
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return SocialLoginButton(
                      iconPath: 'assets/icons/google.png',
                      label: 'Google',
                      onTap:
                          (state is AuthLoadingState ||
                              state is AuthGoogleLoading)
                          ? null
                          : () => context.read<AuthCubit>().signInWithGoogle(),
                    );
                  },
                ),
                const Gap(10),
                // Apple is UI-only for now
                SocialLoginButton(
                  iconPath: 'assets/icons/apple.png',
                  label: 'Apple',
                  onTap: null,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    InkWell(
                      onTap: () => context.pushNamed(AppRoutes.register),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: AppColors.primaryColor),
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
