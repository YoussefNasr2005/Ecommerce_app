import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/custom_cubit_grid_widget.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart'; // 👈 استيراد الموديل الحقيقي
import 'package:ecommerce_app/features/home_screen/widgets/product_item_widget.dart';
import 'package:ecommerce_app/features/search/cubit/search_cubit.dart';
import 'package:ecommerce_app/features/search/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().searchByWord(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results for "${widget.query}"',
          style: AppStyles.black18BoldStyle
              .copyWith(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return CustomCubitGridWidget<Product>(
                  isSearchScreen: true,
                  childAspectRatio: 2.h,
                  crossAxisCount: 1,
                  errorMessage:
                      state is SearchErrorState ? state.errorMessage : null,
                  isLoading: state is SearchLoadingState ||
                      state is SearchInitialState,
                  items: state is SearchLoadedState
                      ? state.productsModel.products
                      : null,
                  onRefresh: () async {
                    context.read<SearchCubit>().searchByWord(widget.query);
                  },
                  itemBuilder: (context, product, index) {
                    return ProductItemWidget(
                      product: product,
                      onTap: () => context.pushNamed(
                        AppRoutes.productScreen,
                        extra: product,
                      ),
                      verticalCard: false,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
