import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/forgot_password/create_new_password.dart';
import 'package:bookia/feature/auth/ui/forgot_password/forget_password_screen.dart';
import 'package:bookia/feature/auth/ui/forgot_password/otp_verfication_screen.dart';
import 'package:bookia/feature/auth/ui/forgot_password/password_changed_screen.dart';
import 'package:bookia/feature/auth/ui/login_screen.dart';
import 'package:bookia/feature/auth/ui/register_screen.dart';
import 'package:bookia/feature/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:bookia/feature/cart/ui/congrates_screen.dart';
import 'package:bookia/feature/cart/ui/place_order_screen.dart';
import 'package:bookia/feature/home/data/models/book_details_arg.dart';
import 'package:bookia/feature/home/ui/book_details/book_deatials_screen.dart';
import 'package:bookia/feature/on_boarding_screen.dart';
import 'package:bookia/feature/profile/ui/new_password_screen.dart';
import 'package:bookia/feature/profile/ui/order_history_screen.dart';
import 'package:bookia/feature/profile/ui/update_profile_screen.dart';
import 'package:bookia/feature/search/cubit/search_cubit.dart';
import 'package:bookia/feature/search/data/model/search_args.dart';
import 'package:bookia/feature/search/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../feature/cart/data/model/place_order_args.dart';
import '../../feature/payment/cubit/payment_cubit.dart';
import '../../feature/payment/ui/paymob_webview_screen.dart';
import '../networking/paymob_service.dart';
import '../theme/app_theme.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case AppRoutes.login:
        final cubit = AuthCubit();
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: cubit, child: const LoginScreen()),
        );

      case AppRoutes.register:
        final cubit = AuthCubit();
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: cubit, child: const RegisterScreen()),
        );
      case AppRoutes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case AppRoutes.otpVerfication:
        return MaterialPageRoute(builder: (_) => OtpVerificationScreen());
      case AppRoutes.createNewPasswordScreen:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordScreen());
      case AppRoutes.passwordChangedSuccess:
        return MaterialPageRoute(builder: (_) => PasswordChangedScreen());
      case AppRoutes.congrates:
        return MaterialPageRoute(builder: (_) => CongratesScreen());
      case AppRoutes.paymentWebView:
        final url = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PaymobWebViewScreen(paymentUrl: url),
        );
      case AppRoutes.payment:
        final args = settings.arguments as PlaceOrderArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PaymentCubit(PaymobService()),
            child: _PaymentLoader(args: args),
          ),
        );
      case AppRoutes.showMyorders:
        return MaterialPageRoute(builder: (_) => MyOrdersScreen());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case AppRoutes.editPassword:
        return MaterialPageRoute(builder: (_) => UpdateNewPasswordScreen());
      case AppRoutes.placeOrder:
        final total = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlaceOrderScreen(total: total),
        );
      case AppRoutes.searchScreen:
        final args = settings.arguments as SearchArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => SearchCubit()),
              BlocProvider.value(value: args.cartCubit),
              BlocProvider.value(value: args.wishlistCubit),
            ],
            child: const SearchScreen(),
          ),
        );

      case AppRoutes.bottomNavBarScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavBarScreen());

      case AppRoutes.booksDetails:
        final args = settings.arguments as BookDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: args.cartCubit),
              BlocProvider.value(value: args.wishlistCubit),
            ],
            child: BookDetailsScreen(book: args.book),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class _PaymentLoader extends StatefulWidget {
  const _PaymentLoader({required this.args});

  final PlaceOrderArgs args;

  @override
  State<_PaymentLoader> createState() => _PaymentLoaderState();
}

class _PaymentLoaderState extends State<_PaymentLoader> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().initiatePayment(
      amount: double.parse(widget.args.total),
      firstName: widget.args.name,
      email: widget.args.email,
      phone: widget.args.phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentUrlReady) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.paymentWebView,
            arguments: state.url,
          );
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: context.appColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: AppColors.primaryColor),
              const Gap(16),
              Text(
                'Preparing your payment...',
                style: TextStyle(
                  color: context.appColors.subtitle,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
