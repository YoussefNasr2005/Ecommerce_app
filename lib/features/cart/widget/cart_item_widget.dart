import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final CartProductModel? cartItem;
  final bool isLoadingMode;
  final VoidCallback? onDelete;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CartItemWidget({
    super.key,
    this.cartItem,
    this.isLoadingMode = false,
    this.onDelete,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1.r),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                width: 85.w,
                height: 85.h,
                imageUrl: product?.thumbnail ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const WidthSpace(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product?.title ?? 'Product',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.black15BoldStyle.copyWith(
                            fontSize: 14.sp,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const WidthSpace(8),
                      InkWell(
                        onTap: onDelete,
                        borderRadius: BorderRadius.circular(6.r),
                        child: Padding(
                          padding: EdgeInsets.all(4.sp),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                  Row(
                    children: [
                      Text(
                        '${product?.price ?? 0} \$',
                        style: AppStyles.black15BoldStyle.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      if ((product?.discountPercentage ?? 0) > 0) ...[
                        const WidthSpace(6),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '-${product?.discountPercentage.round()}%',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const HeightSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${product?.total.toStringAsFixed(2) ?? 0} \$',
                        style: AppStyles.grey12MediumStyle.copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            _buildCounterButton(
                              icon: Icons.remove,
                              onTap: onDecrement,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                '${product?.quantity ?? 1}',
                                style: AppStyles.black15BoldStyle
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ),
                            _buildCounterButton(
                              icon: Icons.add,
                              onTap: onIncrement,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton({required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: 28.w,
        height: 28.h,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16.sp,
          color: Colors.black87,
        ),
      ),
    );
  }
}
