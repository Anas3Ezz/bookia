import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_theme.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  // Static orders for now — replace with API data when ready
  static final List<_OrderItem> _orders = [
    _OrderItem(orderNumber: '238562312', date: '20/03/2025', total: '150'),
    _OrderItem(orderNumber: '847291043', date: '15/03/2025', total: '320'),
    _OrderItem(orderNumber: '563910284', date: '02/03/2025', total: '95'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            Expanded(
              child: _orders.isEmpty
                  ? const _EmptyOrders()
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: _orders.length,
                      separatorBuilder: (_, _) => Divider(
                        color: context.appColors.borderColor,
                        height: 1,
                      ),
                      itemBuilder: (_, index) =>
                          _OrderCard(order: _orders[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _OrderItem data class
// ─────────────────────────────────────────────

class _OrderItem {
  final String orderNumber;
  final String date;
  final String total;

  const _OrderItem({
    required this.orderNumber,
    required this.date,
    required this.total,
  });
}

// ─────────────────────────────────────────────
// _OrderCard
// ─────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final _OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order No${order.orderNumber}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                order.date,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
              ),
            ],
          ),
          Gap(6.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total Amount: \$${order.total}',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _EmptyOrders
// ─────────────────────────────────────────────

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            'No orders yet',
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
