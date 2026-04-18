import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistSyncBanner extends StatefulWidget {
  const WishlistSyncBanner({super.key});

  @override
  State<WishlistSyncBanner> createState() => _WishlistSyncBannerState();
}

class _WishlistSyncBannerState extends State<WishlistSyncBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;
  late final Animation<double> _slideIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _shimmer = Tween<double>(
      begin: -1.5,
      end: 2.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideIn = Tween<double>(begin: -60, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, _slideIn.value),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.appColors.secondaryColor.withValues(alpha: 0.15),
                  context.appColors.secondaryColor.withValues(alpha: 0.08),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: context.appColors.secondaryColor.withValues(
                    alpha: 0.3,
                  ),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated shimmer dots
                _ShimmerDots(shimmerValue: _shimmer.value),
                SizedBox(width: 10.w),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment(_shimmer.value - 1, 0),
                    end: Alignment(_shimmer.value, 0),
                    colors: const [
                      AppColors.secondaryColor,
                      AppColors.primaryLight,
                      AppColors.secondaryColor,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Updating wishlist...',
                    style: AppTextStyle.style(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.surface,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerDots extends StatelessWidget {
  const _ShimmerDots({required this.shimmerValue});

  final double shimmerValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        // Each dot pulses with a slight offset
        final phase = (shimmerValue + index * 0.3) % 2.5;
        final scale = (phase > 0 && phase < 1.2)
            ? 0.6 + (0.4 * (1 - (phase - 0.6).abs() / 0.6).clamp(0.0, 1.0))
            : 0.6;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: 5.w * scale,
          height: 5.w * scale,
          decoration: BoxDecoration(
            color: context.appColors.secondaryColor.withValues(
              alpha: 0.7 + 0.3 * scale,
            ),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
