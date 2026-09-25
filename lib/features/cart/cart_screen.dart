import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_state.dart';
import 'package:ecommerce_app/features/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/widgets/title_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartErrorState) {
              context.showAnimatedSnackBar(
                message: state.message,
                type: AnimatedSnackBarType.error,
              );
            }
          },
          builder: (context, state) {
            // 1. حالة التحميل
            if (state is CartLoadingState) {
              return SingleChildScrollView(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const Column(
                    children: [
                      HeightSpace(16),
                      CartItemWidget(isLoadingMode: true),
                      CartItemWidget(isLoadingMode: true),
                      CartItemWidget(isLoadingMode: true),
                      HeightSpace(20),
                      TitlePriceWidget(isLoadingMode: true),
                      TitlePriceWidget(isLoadingMode: true),
                      TitlePriceWidget(isLoadingMode: true),
                    ],
                  ),
                ),
              );
            }

            // 2. حالة اكتمال التحميل
            if (state is CartLoadedState) {
              final cartModel = state.cartModel;

              // معالجة حالة السلة الفارغة
              if (cartModel.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80.sp,
                        color: Colors.grey.shade400,
                      ),
                      const HeightSpace(16),
                      Text(
                        'Your cart is empty',
                        style: AppStyles.black18BoldStyle,
                      ),
                      const HeightSpace(8),
                      Text(
                        'Looks like you haven\'t added anything yet',
                        style: AppStyles.grey12MediumStyle,
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(16),

                    ...cartModel.products.map(
                      (product) => CartItemWidget(
                        cartItem: product,
                        onDelete: () {},
                        onIncrement: () {},
                        onDecrement: () {},
                      ),
                    ),

                    const HeightSpace(10),
                    const Divider(),
                    const HeightSpace(10),

                    // ملخص الحسابات (مع تصحيح الـ Units)
                    TitlePriceWidget(
                      title: 'Total Items',
                      price: '${cartModel.totalProducts}', // 👈 بدون علامة $
                    ),
                    TitlePriceWidget(
                      title: 'Total Quantity',
                      price: '${cartModel.totalQuantity}', // 👈 بدون علامة $
                    ),
                    TitlePriceWidget(
                      title: 'Total Discounted',
                      price:
                          '${cartModel.discountedTotal.toStringAsFixed(2)} \$',
                    ),

                    const HeightSpace(10),
                    const Divider(),
                    const HeightSpace(10),

                    TotalPriceWidget(
                      title: 'Total Amount',
                      price: '${cartModel.total.toStringAsFixed(2)} \$',
                    ),
                    const HeightSpace(24),

                    PrimaryButtonWidget(
                      buttonText: 'Go To Checkout',
                      trailingIcon: Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      onPress: () {},
                    ),
                    const HeightSpace(24),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
