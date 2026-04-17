import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: context.read<SearchCubit>().onSearchChanged,
      autofocus: true,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: 'Search for books...',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, _) {
            return value.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      controller.clear();
                      context.read<SearchCubit>().onSearchChanged('');
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
      ),
    );
  }
}
