import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_state.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(20),
                  Center(
                    child: Hero(
                      tag: 'id${product.id}',
                      child: CachedNetworkImage(
                        width: 341.w,
                        height: 341.h,
                        imageUrl: product.images[0],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const HeightSpace(12),
                  Text(
                    product.title,
                    style: AppStyles.black16w500Style.copyWith(fontSize: 24.sp),
                  ),
                  const HeightSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18.sp,
                      ),
                      const WidthSpace(2),
                      Text(
                        '${product.rating}/5',
                        style: AppStyles.black15BoldStyle.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const WidthSpace(4),
                    ],
                  ),
                  const HeightSpace(8),
                  Text(
                    product.description,
                    style: AppStyles.grey12MediumStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const HeightSpace(24),
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.inventory_2_outlined,
                          title: 'Availability',
                          value: product.availabilityStatus,
                          valueColor: product.availabilityStatus
                                  .toLowerCase()
                                  .contains('in stock')
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const Divider(height: 20),
                        _buildInfoRow(
                          icon: Icons.local_shipping_outlined,
                          title: 'Shipping',
                          value: product.shippingInformation,
                        ),
                        const Divider(height: 20),
                        _buildInfoRow(
                          icon: Icons.verified_user_outlined,
                          title: 'Warranty',
                          value: product.warrantyInformation,
                        ),
                      ],
                    ),
                  ),
                  const HeightSpace(32),
                  Text(
                    'Reviews',
                    style: AppStyles.black16w500Style.copyWith(fontSize: 24.sp),
                  ),
                  const HeightSpace(10),
                  ...product.reviews.map(
                    (review) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40.sp,
                                width: 40.sp,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.grey.shade700,
                                  size: 22.sp,
                                ),
                              ),
                              const WidthSpace(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.reviewerName,
                                      style: AppStyles.black16w500Style,
                                    ),
                                    Text(
                                      review.reviewerEmail,
                                      style:
                                          AppStyles.grey12MediumStyle.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.ratingColor,
                                    size: 20.sp,
                                  ),
                                  const WidthSpace(2),
                                  Text(
                                    '${review.rating}/5',
                                    style: AppStyles.black15BoldStyle
                                        .copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const HeightSpace(10),
                          Text(
                            review.comment,
                            style: AppStyles.black16w500Style.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const HeightSpace(6),
                          Text(
                            '${review.date.year}/${review.date.month.toString().padLeft(2, '0')}/${review.date.day.toString().padLeft(2, '0')}',
                            style: AppStyles.grey12MediumStyle
                                .copyWith(fontSize: 11.sp),
                          ),
                          const HeightSpace(12),
                          const Divider(height: 1),
                        ],
                      ),
                    ),
                  ),
                  const HeightSpace(120),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    const HeightSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: AppStyles.grey12MediumStyle
                                  .copyWith(fontSize: 16.sp),
                            ),
                            const HeightSpace(4),
                            Text(
                              '${product.price} \$',
                              style: AppStyles.black16w500Style.copyWith(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const WidthSpace(16),
                        BlocConsumer<CartCubit, CartState>(
                          listener: (context, state) {
                            if (state is CartItemAddedState) {
                              context.showAnimatedSnackBar(
                                message: 'Product added successfully to cart.',
                                type: AnimatedSnackBarType.success,
                              );
                            } else if (state is CartItemAddingErrorState) {
                              context.showAnimatedSnackBar(
                                message: state.message,
                                type: AnimatedSnackBarType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state is CartItemAddingLoadingState;

                            return PrimaryButtonWidget(
                              isLoading: isLoading,
                              width: MediaQuery.of(context).size.width * 0.5,
                              buttonText: 'Add To Cart',
                              icon: isLoading
                                  ? null
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                              onPress: () {
                                if (!isLoading) {
                                  context.read<CartCubit>().addToCart(
                                        product: product,
                                        quantity: 1,
                                      );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: Colors.grey.shade700),
        const WidthSpace(10),
        Text(
          title,
          style: AppStyles.grey12MediumStyle.copyWith(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppStyles.black15BoldStyle.copyWith(
              fontSize: 13.sp,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
