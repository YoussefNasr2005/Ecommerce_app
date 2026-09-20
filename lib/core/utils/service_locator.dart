import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/networking/cubit/network_cubit.dart';
import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/utils/local_storage/storage_helper.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/address/repo/address_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/register_cubit.dart';
import 'package:ecommerce_app/features/auth/repo/auth_repo.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit_.dart';
import 'package:ecommerce_app/features/auth/repo/register_repo.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/repo/cart_repo.dart';
import 'package:ecommerce_app/features/home_screen/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:ecommerce_app/features/search/cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setUpServicesLocator() {
  sl.registerSingleton<DioHelper>(DioHelper());
  sl.registerLazySingleton(() => StorageHelper());
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => AuthRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => RegisterRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => HomeRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => UserRepo(sl<DioHelper>()));

  sl.registerLazySingleton(() => AuthCubit(sl<AuthRepo>()));
  sl.registerLazySingleton(() => CartCubit(sl<CartRepo>()));
  sl.registerFactory(() => RegisterCubit(sl<RegisterRepo>()));
  sl.registerFactory(() => ProductsCubit(sl<HomeRepo>()));
  sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  sl.registerFactory(() => SearchCubit(sl<HomeRepo>()));
  sl.registerFactory(() => UserInfoCubit(sl<UserRepo>()));
  sl.registerLazySingleton<NetworkCubit>(
      () => NetworkCubit(connectivity: sl<Connectivity>()));
}
