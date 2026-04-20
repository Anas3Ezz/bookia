// feature/auth/ui/widgets/social_login_section.dart
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'auth_divider.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthDivider(),
        const Gap(10),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final isLoading =
                state is AuthLoadingState || state is AuthGoogleLoading;
            return SocialLoginButton(
              iconPath: 'assets/icons/google.png',
              label: 'Continue with Google',
              onTap: isLoading
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
      ],
    );
  }
}
