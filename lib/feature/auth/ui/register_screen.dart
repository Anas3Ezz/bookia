import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: AppColors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Gap(20),
                const Text(
                  'Hello! Register to get started',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Gap(32),
                CustomTextField(
                  hintText: 'User name',
                  controller: _userNameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isEmpty ? 'Username is required' : null,
                ),
                const Gap(15),
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
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) return 'Password too short';
                    return null;
                  },
                ),
                const Gap(15),
                CustomTextField(
                  hintText: 'Confirm your password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
                          content: Text(state.message), // ✅ shows actual error
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
                    if (state is AuthLoadingState ||
                        state is AuthGoogleLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                    return AppButton(
                      text: 'Register',
                      isFilled: true,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().authRegister(
                            name: _userNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            passwordConfirmation:
                                _confirmPasswordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const Gap(20),
                Row(
                  children: const [
                    Expanded(child: Divider(color: AppColors.borderColor)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider(color: AppColors.borderColor)),
                  ],
                ),
                const Gap(10),
                // ── Google Sign In ────────────────────────────────────────────
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return SocialLoginButton(
                      iconPath: 'assets/icons/google.png',
                      label: 'Continue with Google',
                      onTap:
                          (state is AuthLoadingState ||
                              state is AuthGoogleLoading)
                          ? null
                          : () => context.read<AuthCubit>().signInWithGoogle(),
                    );
                  },
                ),
                const Gap(10),
                SocialLoginButton(
                  iconPath: 'assets/icons/apple.png',
                  label: 'Continue with Apple',
                  onTap: null,
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?  '),
                    InkWell(
                      onTap: () => Navigator.pop(context), // back to login
                      child: const Text(
                        'Login Now',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
