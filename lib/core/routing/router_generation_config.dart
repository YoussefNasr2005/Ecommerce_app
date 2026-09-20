import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/address/address_screen.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/auth/cubit/register_cubit.dart';
import 'package:ecommerce_app/features/auth/login_screen.dart';
import 'package:ecommerce_app/features/auth/register_screen.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/home_screen/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/models/products_model.dart';
import 'package:ecommerce_app/features/main_screen/main_screen.dart';
import 'package:ecommerce_app/features/product_screen/product_screen.dart';
import 'package:ecommerce_app/features/profile/profile_screen.dart';
import 'package:ecommerce_app/features/search/cubit/search_cubit.dart';
import 'package:ecommerce_app/features/search/search_screen.dart';
import 'package:ecommerce_app/features/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
      initialLocation: AppRoutes.splashScreen,
      redirect: (context, state) async {
        final bool hasToken = await sl<StorageHelper>().isThereToken();
        final bool isLogginIn = state.matchedLocation == AppRoutes.loginScreen;
        final bool isRegistering =
            state.matchedLocation == AppRoutes.registerScreen;
        final bool isAuthRoot = isLogginIn || isRegistering;

        if (!hasToken && !isAuthRoot) {
          return AppRoutes.loginScreen;
        }
        if (hasToken && isAuthRoot) {
          return AppRoutes.splashScreen;
        }
        return null;
      },
      routes: [
        GoRoute(
          name: AppRoutes.loginScreen,
          path: AppRoutes.loginScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: AppRoutes.registerScreen,
          path: AppRoutes.registerScreen,
          builder: (context, state) => BlocProvider(
              create: (context) => sl<RegisterCubit>(),
              child: const RegisterScreen()),
        ),
        GoRoute(
            name: AppRoutes.mainScreen,
            path: AppRoutes.mainScreen,
            builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<ProductsCubit>()),
                    BlocProvider(create: (context) => sl<CategoriesCubit>()),
                  ],
                  child: const MainScreen(),
                )),
        GoRoute(
          name: AppRoutes.productScreen,
          path: AppRoutes.productScreen,
          builder: (context, state) {
            final product = state.extra as Product;
            return ProductScreen(product: product);
          },
        ),
        GoRoute(
            name: AppRoutes.cartScreen,
            path: AppRoutes.cartScreen,
            builder: (context, state) => const CartScreen()),
        GoRoute(
            name: AppRoutes.splashScreen,
            path: AppRoutes.splashScreen,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
          name: AppRoutes.addressScreen,
          path: AppRoutes.addressScreen,
          builder: (context, state) => BlocProvider(
              create: (context) => sl<UserInfoCubit>(),
              child: const AddressScreen()),
        ),
        GoRoute(
            name: AppRoutes.profileScreen,
            path: AppRoutes.profileScreen,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => sl<UserInfoCubit>(),
                child: const ProfileScreen(),
              );
            }),
        GoRoute(
            name: AppRoutes.searchScreen,
            path: AppRoutes.searchScreen,
            builder: (context, state) {
              final String query = state.extra as String;
              return BlocProvider(
                  create: (context) => sl<SearchCubit>(),
                  child: SearchScreen(query: query));
            }),
      ]);
}
