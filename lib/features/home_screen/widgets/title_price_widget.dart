import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitlePriceWidget extends StatelessWidget {
  final String? title;
  final String? price;
  final bool isLoadingMode;
  const TitlePriceWidget(
      {super.key,
      this.title = 'Sub Total',
      this.price = '1190 \$',
      this.isLoadingMode = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          isLoadingMode
              ? Container(
                  height: 20.h,
                  width: 100.w,
                  color: Colors.grey.shade300,
                )
              : Text(title!,
                  style: AppStyles.black18BoldStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.grey)),
          const Spacer(),
          isLoadingMode
              ? Container(
                  height: 20.h,
                  width: 80.w,
                  color: Colors.grey.shade300,
                )
              : Text(price!,
                  style: AppStyles.black15BoldStyle
                      .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  final String title;
  final String price;
  const TotalPriceWidget({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Text(title,
              style: AppStyles.black15BoldStyle
                  .copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(price,
              style: AppStyles.black18BoldStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}
