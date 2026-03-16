import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

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
          }
        },
        buildWhen: (previous, current) => current is GetCartState,
        builder: (context, state) {
          if (state is GetCartLoading || state is CartInitial) {
            return const _CartSkeletonList();
          } else if (state is GetCartSuccess) {
            final items = state.cart.cartItems ?? [];
            if (items.isEmpty) {
              return const _CartEmpty();
            }
            return _CartContent(cart: state.cart);
          } else if (state is GetCartError) {
            return _CartError(
              message: state.message,
              onRetry: () => context.read<CartCubit>().getCart(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _CartContent
// ─────────────────────────────────────────────

class _CartContent extends StatelessWidget {
  const _CartContent({required this.cart});

  final CartData cart;

  @override
  Widget build(BuildContext context) {
    final items = cart.cartItems ?? [];
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: items.length,
            separatorBuilder: (_, __) => Gap(12.h),
            itemBuilder: (context, index) => _CartItemCard(item: items[index]),
          ),
        ),
        _CartCheckoutBar(total: cart.total ?? '0'),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// _CartItemCard
// ─────────────────────────────────────────────

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CustomCachedImage(
            url: item.itemProductImage ?? '',
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.itemProductName ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(4.h),
              Text(
                '\$${item.itemProductPriceAfterDiscount?.toStringAsFixed(2) ?? item.itemProductPrice ?? ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFB89B5E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.h),
              _QuantityControls(quantity: item.itemQuantity ?? 1),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// _QuantityControls
// ─────────────────────────────────────────────

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuantityButton(icon: Icons.add, onTap: () {}),
        Gap(8.w),
        Text(
          quantity.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        Gap(8.w),
        _QuantityButton(icon: Icons.remove, onTap: () {}),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20.sp, color: Colors.black),
    );
  }
}

// ─────────────────────────────────────────────
// _CartCheckoutBar
// ─────────────────────────────────────────────

class _CartCheckoutBar extends StatelessWidget {
  const _CartCheckoutBar({required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              Text(
                '\$ $total',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Gap(12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB89B5E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _CartSkeletonList
// ─────────────────────────────────────────────

class _CartSkeletonList extends StatelessWidget {
  const _CartSkeletonList();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: 4,
        separatorBuilder: (_, __) => Gap(12.h),
        itemBuilder: (_, __) => Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14.h, color: Colors.grey),
                  Gap(8.h),
                  Container(height: 14.h, width: 80.w, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _CartEmpty
// ─────────────────────────────────────────────

class _CartEmpty extends StatelessWidget {
  const _CartEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _CartError
// ─────────────────────────────────────────────

class _CartError extends StatelessWidget {
  const _CartError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            message,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
          ),
          Gap(12.h),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
