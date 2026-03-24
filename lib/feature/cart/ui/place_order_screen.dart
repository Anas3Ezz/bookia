import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:bookia/core/widgets/customr_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.total});

  final String total;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGovernorate;

  // Static list for now — replace with API call when ready
  static const List<String> _governorates = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Luxor',
    'Aswan',
    'Port Said',
    'Suez',
    'Mansoura',
    'Tanta',
    'Zagazig',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSubmitOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedGovernorate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a governorate'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      context.pushNamed(AppRoutes.congrates);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16.h),
                      const CustomBackButton(),
                      Gap(32.h),
                      Text(
                        'Place Your Order',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        'Fill in your details to complete your order.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade500,
                          height: 1.5,
                        ),
                      ),
                      Gap(32.h),
                      CustomTextField(
                        hintText: 'Full Name',
                        controller: _fullNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: 'Address',
                        controller: _addressController,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: 'Phone',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      _GovernorateDropdown(
                        value: _selectedGovernorate,
                        governorates: _governorates,
                        onChanged: (value) =>
                            setState(() => _selectedGovernorate = value),
                      ),
                      Gap(32.h),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom bar — total + submit button
            _OrderBottomBar(total: widget.total, onSubmit: _onSubmitOrder),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _GovernorateDropdown
// ─────────────────────────────────────────────

class _GovernorateDropdown extends StatelessWidget {
  const _GovernorateDropdown({
    required this.value,
    required this.governorates,
    required this.onChanged,
  });

  final String? value;
  final List<String> governorates;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE8ECF4)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            'Governorate',
            style: TextStyle(color: const Color(0xFF8391A1), fontSize: 14.sp),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF8391A1),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
          items: governorates
              .map(
                (gov) => DropdownMenuItem<String>(
                  value: gov,
                  child: Text(
                    gov,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _OrderBottomBar
// ─────────────────────────────────────────────

class _OrderBottomBar extends StatelessWidget {
  const _OrderBottomBar({required this.total, required this.onSubmit});

  final String total;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 28.h),
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
          AppButton(
            text: 'Submit Order',
            onPressed: onSubmit,
            isFilled: true,
            backgroundColor: const Color(0xFFBB9457),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
