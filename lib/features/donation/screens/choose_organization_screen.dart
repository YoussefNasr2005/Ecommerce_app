import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChooseOrganizationScreen extends StatefulWidget {
  const ChooseOrganizationScreen({
    super.key,
  });

  @override
  State<ChooseOrganizationScreen> createState() =>
      _ChooseOrganizationScreenState();
}

class _ChooseOrganizationScreenState extends State<ChooseOrganizationScreen> {
  int _selectedIndex = 0;
  String organName = '';

  final List<Map<String, String>> _organizations = [
    {'name': 'Hope Community', 'desc': 'Supporting families in need.'},
    {
      'name': 'Warm Hearts',
      'desc': 'Helping communities through clothing donations.'
    },
    {
      'name': 'Clothes For Everyone',
      'desc': 'Providing essential clothing to families.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Organization', style: AppStyles.black18BoldStyle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Select where you would like to donate your clothes.',
            style: AppStyles.subtitlesStyles,
          ),
          const HeightSpace(16),
          ..._organizations.indexed.map(
            (entry) {
              final index = entry.$1;
              final org = entry.$2;
              organName = org['name'] as String;
              final bool isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.borderColor,
                      width: isSelected ? 2.w : 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(Icons.home_work_outlined,
                            color: AppColors.primaryColor, size: 28.w),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(org['name']!,
                                style: AppStyles.productTitleStyle),
                            SizedBox(height: 4.h),
                            Text(org['desc']!,
                                style: AppStyles.productDescriptionStyle),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                        size: 24.w,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const HeightSpace(16),
          Align(
            alignment: Alignment.center,
            child: PrimaryButtonWidget(
                buttonText: 'Continue',
                onPress: () {
                  final selectedOrgName =
                      _organizations[_selectedIndex]['name']!;

                  context
                      .read<DonationCubit>()
                      .setSelectedOrganization(selectedOrgName);

                  context.pushNamed(
                    AppRoutes.contactAndPickupScreen,
                    extra: context.read<DonationCubit>(),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
