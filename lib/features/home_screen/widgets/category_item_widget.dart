import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemWidget extends StatelessWidget {
  final String categoryName;
  final bool isSelectedCtegory;
  const CategoryItemWidget(
      {super.key, required this.categoryName, required this.isSelectedCtegory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelectedCtegory ? AppColors.primaryColor : null,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(categoryName,
            style: AppStyles.black15BoldStyle.copyWith(
                color: isSelectedCtegory ? AppColors.whiteColor : null)),
      ),
    );
  }
}
