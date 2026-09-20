import 'package:ecommerce_app/core/networking/listener/network_listener_wrapper.dart';
import 'package:ecommerce_app/core/routing/router_generation_config.dart';
import 'package:ecommerce_app/core/styling/theme_data.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit_.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServicesLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<CartCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<AuthCubit>(),
            ),
          ],
          child: MaterialApp.router(
            builder: (context, child) {
              return NetworkListenerWrapper(
                child: child ?? const SizedBox.shrink(),
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppThemes.lightTheme,
            routerConfig: RouterGenerationConfig.goRouter,
          ),
        );
      },
    );
  }
}
