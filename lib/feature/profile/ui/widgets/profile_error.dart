import 'package:bookia/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileError extends StatelessWidget {
  const ProfileError({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => context.read<ProfileCubit>().getProfile(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
