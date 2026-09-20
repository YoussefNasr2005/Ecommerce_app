import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_assets.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/account/widgets/account_item_widget.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.details,
            title: 'My Profile',
            onTap: () => context.pushNamed(
              AppRoutes.profileScreen,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.address,
            title: 'Address Book',
            onTap: () {
              context.pushNamed(
                AppRoutes.addressScreen,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.question,
            title: 'FAQ',
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.help,
            title: 'Help Center',
            onTap: () {},
          ),
          const HeightSpace(16),
          const Divider(
            thickness: 8,
            color: Color(0xffE6E6E6),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: GestureDetector(
              onTap: () => _showLogOutDialog(context),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                    size: 25.sp,
                  ),
                  const WidthSpace(8),
                  Text(
                    'Logout',
                    style: AppStyles.black15BoldStyle
                        .copyWith(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ),
          const HeightSpace(20),
        ],
      ),
    );
  }

  _showLogOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            child: SizedBox(
              height: 300.h,
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 164, 159),
                          shape: BoxShape.circle,
                          border: BoxBorder.all(
                              color: const Color(0xffED1010), width: 3.sp)),
                      child: const Icon(Icons.priority_high_rounded,
                          color: Color(0xffED1010)),
                    ),
                    HeightSpace(20.h),
                    Text(
                      'Logout?',
                      style: AppStyles.black18BoldStyle,
                    ),
                    HeightSpace(5.h),
                    Text(
                      'Are you sure you want logout?',
                      style: AppStyles.grey12MediumStyle,
                    ),
                    HeightSpace(20.h),
                    PrimayButtonWidget(
                      buttonText: 'Yes, Logout',
                      onPress: () async {
                        Navigator.of(dialogContext).pop();
                        await context.read<AuthCubit>().logOut();
                        if (context.mounted) {
                          context.goNamed(AppRoutes.loginScreen);
                        }
                      },
                      buttonColor: const Color(0xffED1010),
                    ),
                    HeightSpace(12.h),
                    PrimayButtonWidget(
                      buttonText: 'No, Cancel',
                      onPress: () => context.pop(),
                      textColor: AppColors.blackColor,
                      buttonColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
