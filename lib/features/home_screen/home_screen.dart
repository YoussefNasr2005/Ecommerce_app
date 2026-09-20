import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/custom_cubit_grid_widget.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home_screen/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/categories_state.dart';
import 'package:ecommerce_app/features/home_screen/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/products_state.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:ecommerce_app/features/home_screen/widgets/category_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  String currentCat = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().fetchProducts();
    context.read<CategoriesCubit>().featchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(28),
          SizedBox(
            width: 335.w,
            child: Text(
              'Explore Products',
              style: AppStyles.primaryHeadLinesStyle.copyWith(fontSize: 25.sp),
            ),
          ),
          const HeightSpace(16),
          Row(
            children: [
              CustomTextField(
                controller: _searchController,
                width: 270.w,
                hintText: 'Search products ....',
                onFieldSubmitted: (value) {
                  final query = _searchController.text.trim();
                  if (query.isNotEmpty) {
                    context.pushNamed(AppRoutes.searchScreen, extra: query);
                  }
                  _searchController.clear();
                },
              ),
              const WidthSpace(8),
              GestureDetector(
                onTap: () {
                  final query = _searchController.text.trim();
                  if (query.isNotEmpty) {
                    context.pushNamed(AppRoutes.searchScreen, extra: query);
                  }
                  _searchController.clear();
                },
                child: Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const HeightSpace(16),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoadedState) {
                final categories = state.categories;
                return SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          if (selectedCategoryIndex == index) return;

                          setState(() {
                            selectedCategoryIndex = index;
                            currentCat = categories[index];
                          });

                          if (index == 0) {
                            context.read<ProductsCubit>().fetchProducts();
                          } else {
                            context
                                .read<ProductsCubit>()
                                .fetchProductsCategories(categories[index]);
                          }
                        },
                        child: CategoryItemWidget(
                          categoryName: categories[index],
                          isSelectedCtegory: isSelected,
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const HeightSpace(16),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return CustomCubitGridWidget<Product>(
                  childAspectRatio: .5.h,
                    isLoading: state is ProductsLoadinState ? true : false,
                    errorMessage:
                        state is ProductsErrorState ? state.errorMessage : null,
                    items: state is ProductsLoadedState
                        ? state.products.products
                        : [],
                    onRefresh: () async {
                      if (currentCat == 'All') {
                        await context.read<ProductsCubit>().fetchProducts();
                      } else {
                        await context
                            .read<ProductsCubit>()
                            .fetchProductsCategories(currentCat);
                      }
                    },
                    itemBuilder: ((context, item, index) {
                      if (state is ProductsLoadedState) {
                        final product = state.products.products;

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 100.0,
                            child: FadeInAnimation(
                              child: ProductItemWidget(
                                product: product[index],
                                onTap: () => context.pushNamed(
                                    AppRoutes.productScreen,
                                    extra: product[index]),
                                verticalCard: true,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }));
              },
            ),
          )
        ],
      ),
    );
  }
}
