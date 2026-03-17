import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_content.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_empty.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_error.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_skeleton_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AddToCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is UpdateCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (_, current) =>
            current is GetCartState || current is CartInitial,
        builder: (context, state) {
          if (state is GetCartLoading || state is CartInitial) {
            return const CartSkeletonList();
          } else if (state is GetCartSuccess) {
            final items = state.cart.cartItems ?? [];
            if (items.isEmpty) return const CartEmpty();
            return CartContent(cart: state.cart);
          } else if (state is GetCartError) {
            return CartError(
              message: state.message,
              onRetry: () => context.read<CartCubit>().getCart(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
