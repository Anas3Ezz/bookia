import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/feature/profile/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_header.dart';
import 'package:bookia/feature/profile/ui/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  void _showLogoutDialog(BuildContext context) {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (_, current) => current is LogoutState,
              builder: (context, state) {
                if (state is LogoutLoading) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.black),
                  onPressed: () => _showLogoutDialog(context),
                );
              },
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (_, current) => current is GetProfileState,
          builder: (context, state) {
            if (state is GetProfileLoading || state is ProfileInitial) {
              return const _ProfileSkeleton();
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () =>
                          context.read<ProfileCubit>().getProfile(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _ProfileSkeleton
// ─────────────────────────────────────────────

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 160.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
