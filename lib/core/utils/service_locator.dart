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
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:ecommerce_app/features/donation/data/data_sources/donation_local_data_source.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_clothes_model.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_model.dart';
import 'package:ecommerce_app/features/donation/screens/contact_and_packup_screen.dart';
import 'package:ecommerce_app/features/home_screen/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:ecommerce_app/features/search/cubit/search_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServicesLocator() async {
  sl.registerSingleton<DioHelper>(DioHelper());

  await Hive.initFlutter();
  Hive.registerAdapter(DonationModelAdapter());
  Hive.registerAdapter(DonationClothesModelAdapter());
  Hive.registerAdapter(DonationStatusAdapter());
  Hive.registerAdapter(PickupTimeAdapter());
  Hive.registerAdapter(ContactMethodAdapter());
  final donationBox = await Hive.openBox<DonationModel>('donations_box');
  sl.registerLazySingleton<Box<DonationModel>>((() => donationBox));
  sl.registerLazySingleton<FlutterSecureStorage>(() =>
      const FlutterSecureStorage(aOptions: AndroidOptions(resetOnError: true)));

  sl.registerLazySingleton<DonationLocalDataSource>(
      () => DonationLocalDataSource(donationBox));

  sl.registerLazySingleton(() => StorageHelper(sl<FlutterSecureStorage>()));
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton(() => AuthRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => RegisterRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => HomeRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));
  sl.registerLazySingleton(() => UserRepo(sl<DioHelper>()));

  sl.registerLazySingleton(() => CartCubit(sl<CartRepo>()));
  sl.registerLazySingleton(() => UserInfoCubit(sl<UserRepo>()));
  sl.registerLazySingleton(() => AuthCubit(sl<AuthRepo>()));
  sl.registerLazySingleton(() => DonationCubit(sl<DonationLocalDataSource>()));
  sl.registerFactory(() => RegisterCubit(sl<RegisterRepo>()));
  sl.registerFactory(() => ProductsCubit(sl<HomeRepo>()));
  sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  sl.registerFactory(() => SearchCubit(sl<HomeRepo>()));
  sl.registerLazySingleton<NetworkCubit>(
      () => NetworkCubit(connectivity: sl<Connectivity>()));
}
