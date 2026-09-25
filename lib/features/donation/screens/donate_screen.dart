import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/lottie_loading.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_state.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_state.dart';
import 'package:ecommerce_app/features/donation/data/models/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DonationCubit>().fetchAllDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserInfoCubit, UserInfoState>(
                builder: (context, state) {
              final userModel = context.read<UserInfoCubit>().currentUser;
              final firstName = userModel?.firstName ?? 'There';
              return Text(
                'Welcome $firstName,\nDonate & Make an Impact',
                style: AppStyles.black16w500Style,
              );
            }),
            Text(
              'Give your clothes a second life.',
              style: AppStyles.grey12MediumStyle.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroCard(
                  onPress: () => context.pushNamed(
                      AppRoutes.selectClothesScreen,
                      extra: context.read<DonationCubit>())),
              const HeightSpace(60),
              _buildImpactSection(),
              const HeightSpace(16),
              Text(
                'Recent Donation Activity',
                style: AppStyles.black16w500Style,
              ),
              const HeightSpace(16),
              _buildRecentDonations(),
              const HeightSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRecentDonations() {
  return BlocBuilder<DonationCubit, DonationState>(builder: ((context, state) {
    if (state is DonationLoadingState) {
      return const Center(child: LottieLoading());
    }
    if (state is DonationErrorState) {
      return Center(child: Text(state.message ?? 'Something went wrong!'));
    }
    if (state is DonationsLoadedState) {
      final donations = state.donations;
      if (donations.isEmpty) {
        return Center(
            child: Text(
          'No donations yet. Start making an impact today!',
          style: AppStyles.grey12MediumStyle,
        ));
      }
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            border: const Border(
              top: BorderSide(color: AppColors.borderColor, width: 5),
              left: BorderSide(color: AppColors.borderColor, width: 5),
              right: BorderSide(color: AppColors.borderColor, width: 5),
            ),
          ),
          height: 300.h,
          child: SingleChildScrollView(
              child: Column(
                  children: donations.map((d) {
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor, width: 1.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_work_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                d.organizationName,
                                style: AppStyles.black15BoldStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: d.status == DonationStatus.completed
                              ? AppColors.successColor.withOpacity(0.1)
                              : d.status == DonationStatus.accepted
                                  ? AppColors.primaryColor.withOpacity(0.1)
                                  : AppColors.ratingColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          d.status == DonationStatus.completed
                              ? 'Completed'
                              : d.status == DonationStatus.accepted
                                  ? 'Accepted'
                                  : 'Pending',
                          style: AppStyles.grey12MediumStyle.copyWith(
                            color: d.status == DonationStatus.completed
                                ? AppColors.successColor
                                : d.status == DonationStatus.accepted
                                    ? AppColors.primaryColor
                                    : AppColors.ratingColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  const HeightSpace(12),
                  Divider(color: AppColors.borderColor, height: 1.h),
                  const HeightSpace(12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.checkroom_outlined,
                                    size: 14.sp, color: AppColors.greyColor),
                                SizedBox(width: 4.w),
                                Text('Items',
                                    style: AppStyles.grey12MediumStyle),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              d.clothes.formattedSummary,
                              style: AppStyles.productTitleStyle
                                  .copyWith(fontSize: 13.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone_outlined,
                                    size: 14.sp, color: AppColors.greyColor),
                                SizedBox(width: 4.w),
                                Text('Contact',
                                    style: AppStyles.grey12MediumStyle),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              d.contactMethod,
                              style: AppStyles.productTitleStyle
                                  .copyWith(fontSize: 13.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_outlined,
                                    size: 14.sp, color: AppColors.greyColor),
                                SizedBox(width: 4.w),
                                Text('Pickup',
                                    style: AppStyles.grey12MediumStyle),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(d.pickupTime,
                                style: AppStyles.productTitleStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList())));
    }
    return const SizedBox.shrink();
  }));
}

Widget _buildHeroCard({required Function() onPress}) {
  return Container(
    width: 350.h,
    padding: EdgeInsets.all(16.sp),
    decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffCFE5FF),
            Color.fromARGB(14, 207, 229, 255),
          ],
          begin: Alignment.center,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(width: .5.w, color: AppColors.greyColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: const Color(0xffCFE5FF)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco),
                Text(
                  'Zero Waste Initiative',
                  style: AppStyles.black16w500Style.copyWith(fontSize: 12.sp),
                ),
              ],
            )),
        const HeightSpace(8),
        SizedBox(
            width: 236.w,
            child: Text('Give Clothes. Make a Difference.',
                style: AppStyles.black18BoldStyle)),
        const HeightSpace(8),
        SizedBox(
            width: 236.w,
            child: Text(
                'Donate clothes you no longer need and help them reach people who need them.',
                style: AppStyles.black15BoldStyle
                    .copyWith(color: AppColors.primaryColor))),
        const HeightSpace(16),
        PrimaryButtonWidget(
          width: 196.w,
          height: 46.h,
          buttonText: 'Start a Donation',
          onPress: onPress,
          icon: Icon(
            Icons.add_box_outlined,
            color: AppColors.backgroundColor,
            size: 20.sp,
          ),
        ),
      ],
    ),
  );
}

Widget _buildImpactSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Your Impact', style: AppStyles.black16w500Style),
      const SizedBox(height: 12.0),
      BlocBuilder<DonationCubit, DonationState>(builder: (context, state) {
        if (state is DonationErrorState) {
          return const Center(child: Text('Something went wrong'));
        }
        if (state is DonationLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        }

        if (state is DonationsLoadedState) {
          return Row(
            children: [
              Expanded(
                  child: _buildStatCard(
                      state.pendingDonation!.length.toString(),
                      'Items Donated',
                      Icons.dry_cleaning_outlined)),
              const SizedBox(width: 12.0),
              Expanded(
                  child: _buildStatCard(
                      state.acceptedDonation!.length.toString(),
                      'Donations',
                      Icons.inventory_2_outlined)),
              const SizedBox(width: 12.0),
              Expanded(
                  child: _buildStatCard(
                      state.completedDonation!.length.toString(),
                      'Completed',
                      Icons.task_alt_outlined)),
            ],
          );
        }
        return Row(
          children: [
            Expanded(
                child: _buildStatCard(
                    '0', 'Items Donated', Icons.dry_cleaning_outlined)),
            const SizedBox(width: 12.0),
            Expanded(
                child:
                    _buildStatCard('0', 'Active', Icons.inventory_2_outlined)),
            const SizedBox(width: 12.0),
            Expanded(
                child:
                    _buildStatCard('0', 'Completed', Icons.task_alt_outlined)),
          ],
        );
      })
    ],
  );
}

Widget _buildStatCard(String count, String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: AppColors.borderColor, width: 1.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: AppColors.secondaryColor, size: 22.0),
        const SizedBox(height: 8.0),
        Text(count, style: AppStyles.black18BoldStyle),
        const SizedBox(height: 2.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.ratingColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
