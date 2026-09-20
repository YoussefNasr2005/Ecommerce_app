import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

class CustomCubitGridWidget<T extends Object> extends StatelessWidget {
  final bool isLoading;
  final bool? isSearchScreen;
  final String? errorMessage;
  final List<T>? items;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;

  const CustomCubitGridWidget({
    super.key,
    required this.isLoading,
    this.errorMessage,
    this.items,
    required this.onRefresh,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.5,
    this.isSearchScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage!,
          style: AppStyles.black15BoldStyle,
        ),
      );
    }

    // إظهار الشيمر أثناء التحميل
    if (isLoading) {
      return isSearchScreen == false
          ? Shimmer.fromColors(
              highlightColor: Colors.grey.shade100,
              baseColor: Colors.grey.shade300,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 16.sp,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 150.h,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const HeightSpace(10),
                    Container(
                      height: 30.h,
                      width: 150.h,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
    }

    // إذا كانت القائمة null (مثل حالة الـ Initial قبل التحميل) لا نعرض شيء أو نعرض loading
    if (items == null) {
      return const SizedBox.shrink();
    }

    // إذا اكتمل التحميل والقائمة فعلياً فارغة
    if (items!.isEmpty) {
      return const Center(
        child: Text('No items found'),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: onRefresh,
      child: AnimationLimiter(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 20.h,
            crossAxisSpacing: 50.sp,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: items!.length,
          itemBuilder: (context, index) {
            final item = items![index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: crossAxisCount,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: itemBuilder(context, item, index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
