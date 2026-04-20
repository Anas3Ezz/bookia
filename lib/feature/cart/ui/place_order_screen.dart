import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/helper/validators.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_theme.dart';

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
      context.pushNamed(AppRoutes.payment, arguments: widget.total);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
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
                          color: context.appColors.textPrimary,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        'Fill in your details to complete your order.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.5,
                          color: context.appColors.subtitle,
                        ),
                      ),
                      Gap(32.h),
                      CustomTextField(
                        hintText: 'Full Name',
                        controller: _fullNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.name,
                      ),
                      Gap(16.h),
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        validator: AppValidators.email,
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
                        validator: AppValidators.phone,
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
        color: context.appColors.fillColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.appColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: context.appColors.surface,
          hint: Text(
            'Governorate',
            style: TextStyle(fontSize: 14.sp, color: context.appColors.hint),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.appColors.hint,
          ),
          borderRadius: BorderRadius.circular(8.r),
          items: governorates
              .map(
                (gov) => DropdownMenuItem<String>(
                  value: gov,
                  child: Text(
                    gov,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.appColors.textColor,
                    ),
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
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: context.appColors.subtitle,
                ),
              ),
              Text(
                '\$ $total',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textPrimary,
                ),
              ),
            ],
          ),
          Gap(12.h),
          AppButton(
            text: 'Submit Order',
            onPressed: onSubmit,
            isFilled: true,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
