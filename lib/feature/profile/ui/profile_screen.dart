import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/feature/profile/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_appbar.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_error.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_header.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_menu.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileCubit>().logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.onboarding,
            (route) => false,
          );
        } else if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: ProfileAppBar(onLogoutTap: _showLogoutDialog),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (_, current) => current is GetProfileState,
          builder: (context, state) {
            if (state is GetProfileLoading || state is ProfileInitial) {
              return const ProfileSkeleton();
            } else if (state is GetProfileSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeader(
                      name: state.profile.name ?? '',
                      email: state.profile.email ?? '',
                      imageUrl: state.profile.image ?? '',
                    ),
                    const SizedBox(height: 24),
                    const ProfileMenu(),
                  ],
                ),
              );
            } else if (state is GetProfileError) {
              return ProfileError(message: state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
