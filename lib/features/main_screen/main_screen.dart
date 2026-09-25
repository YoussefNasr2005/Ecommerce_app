import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/features/account/account_screen.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:ecommerce_app/features/donation/screens/donate_screen.dart';
import 'package:ecommerce_app/features/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    BlocProvider(
        create: (context) => sl<DonationCubit>(), child: const DonateScreen()),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 1,
        iconSize: 30.sp,
        selectedItemColor: AppColors.primaryColor,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          switch (value) {
            case 1:
              context.read<CartCubit>().fetchCarts();
              break;
            default:
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.volunteer_activism,
              ),
              label: 'Donate'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_3_outlined,
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
