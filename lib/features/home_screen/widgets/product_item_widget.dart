import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final bool verticalCard;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavorite;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.verticalCard,
    this.onTap,
    this.onAddToCart,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return verticalCard
        ? _buildVerticalCard()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildHorizontalCard());
  }

  Widget _buildVerticalCard() {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.borderColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(
                width: double.infinity,
                height: 150.h,
              ),
              const HeightSpace(8),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.productTitleStyle,
              ),
            
              const HeightSpace(5),
            
              _buildPrice(),
           
              const HeightSpace(7),
             
              _buildRating(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalCard() {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: AppColors.borderColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(
                width: 125.w,
                height: 145.h,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.productTitleStyle.copyWith(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                      ],
                    ),

                    const HeightSpace(6),

                    // Description
                    Text(
                      product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.productDescriptionStyle,
                    ),

                    const HeightSpace(7),

                    _buildPrice(),

                    const HeightSpace(7),

                    _buildRating(),

                    const HeightSpace(8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Hero(
            tag: 'id${product.id}',
            child: CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: product.thumbnail,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Container(
                  width: width,
                  height: height,
                  color: AppColors.backgroundColor,
                  child: Center(
                    child: SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  width: width,
                  height: height,
                  color: AppColors.backgroundColor,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 34.sp,
                    color: AppColors.greyColor,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.ratingColor,
          size: 17.sp,
        ),
        SizedBox(width: 3.w),
        Text(
          product.rating.toStringAsFixed(1),
          style: AppStyles.productRatingStyle,
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            product.price.toStringAsFixed(2),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.productPriceStyle,
          ),
        ),
        SizedBox(width: 4.w),
        Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Text(
            '\$',
            style: AppStyles.productCurrencyStyle,
          ),
        ),
      ],
    );
  }
}
