import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_clothes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectClothesScreen extends StatefulWidget {
  const SelectClothesScreen({
    super.key,
  });

  @override
  State<SelectClothesScreen> createState() => _SelectClothesScreenState();
}

class _SelectClothesScreenState extends State<SelectClothesScreen> {
  DonationClothesModel? selectedClothes;
  final List<Map<String, dynamic>> _clothesList = [
    {'name': 'T-Shirts', 'icon': Icons.checkroom, 'count': 0},
    {'name': 'Pants', 'icon': Icons.dry_cleaning, 'count': 0},
    {'name': 'Jackets', 'icon': Icons.inventory_2_outlined, 'count': 0},
    {'name': 'Dresses', 'icon': Icons.accessibility_new, 'count': 0},
    {'name': 'Shoes', 'icon': Icons.snowshoeing, 'count': 0},
  ];

  int get _totalItems =>
      _clothesList.fold(0, (sum, value) => sum + value['count'] as int);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Clothes', style: AppStyles.black18BoldStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Choose the clothes you would like to donate.',
              style: AppStyles.subtitlesStyles,
            ),
          ),
          ..._clothesList.indexed.map((entry) {
            final index = entry.$1;
            final item = entry.$2;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor, width: 1.w),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(item['icon'],
                          color: AppColors.secondaryColor, size: 24.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(item['name'],
                            style: AppStyles.black16w500Style),
                      ),
                      _buildCounter(
                        index: index,
                        count: item['count'],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Align(
            alignment: Alignment.center,
            child: _buildBottomAction(onPress: () {
              selectedClothes = DonationClothesModel(
                  tShirts: _clothesList[0]['count'],
                  pants: _clothesList[1]['count'],
                  jackets: _clothesList[2]['count'],
                  dresses: _clothesList[3]['count'],
                  shoes: _clothesList[4]['count']);
                  
              context
                  .read<DonationCubit>()
                  .setSelectedClothes(selectedClothes!);

              context.pushNamed(AppRoutes.chooseOrganizationScreen,
                  extra: context.read<DonationCubit>());
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter({
    required int index,
    required int count,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            count > 0
                ? setState(() {
                    _clothesList[index]['count']--;
                  })
                : null;
          },
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(Icons.remove,
                size: 20.w,
                color: count > 0 ? AppColors.blackColor : AppColors.greyColor),
          ),
        ),
        SizedBox(width: 16.w),
        Text('${_clothesList[index]['count']}'),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () {
            setState(() => _clothesList[index]['count']++);
          },
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(Icons.add, size: 20.w, color: AppColors.blackColor),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction({required Function() onPress}) {
    final bool canContinue = _totalItems > 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$_totalItems Items Selected', style: AppStyles.black15BoldStyle),
        SizedBox(height: 16.h),
        PrimaryButtonWidget(
          buttonText: 'Continue',
          onPress: canContinue ? onPress : null,
        ),
      ],
    );
  }
}
