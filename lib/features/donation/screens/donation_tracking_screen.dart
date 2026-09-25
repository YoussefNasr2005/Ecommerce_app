import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/utils/animated_snack_bar.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DonationTrackingScreen extends StatelessWidget {
  const DonationTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DonationCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Donation Tracking', style: AppStyles.black18BoldStyle),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const HeightSpace(24),
            _buildTimeline(),
            const HeightSpace(32),
            Text('Donation Details', style: AppStyles.black18BoldStyle),
            const HeightSpace(12),
            _buildDetailsCard(cubit),
            const HeightSpace(24),
            BlocConsumer<DonationCubit, DonationState>(
              listener: (context, state) {
                if (state is DonationSubmitSuccessState) {
                  context.showAnimatedSnackBar(
                    message:
                        'Your donation request has been submitted successfully.',
                    type: AnimatedSnackBarType.success,
                  );
                  context.read<DonationCubit>().fetchAllDonations();
                  context.goNamed(AppRoutes.mainScreen);
                } else if (state is DonationErrorState) {
                  context.showAnimatedSnackBar(
                    message:
                        'Failed to submit your donation. Please try again.',
                    type: AnimatedSnackBarType.error,
                  );
                }
              },
              builder: (context, state) {
                return Align(
                  alignment: Alignment.center,
                  child: PrimaryButtonWidget(
                    buttonText: 'Confirm Donation',
                    isLoading: state is DonationLoadingState,
                    onPress: () {
                      cubit.submitDonation();
                    },
                  ),
                );
              },
            ),
            const HeightSpace(16),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Donation #DON-1024', style: AppStyles.black15BoldStyle),
              Text('3 Items', style: AppStyles.productDescriptionStyle),
            ],
          ),
          const HeightSpace(8),
          Text('Hope Community', style: AppStyles.productTitleStyle),
          const HeightSpace(16),
          Divider(color: AppColors.borderColor, height: 1.h),
          const HeightSpace(12),
          Text('Current Status:', style: AppStyles.grey12MediumStyle),
          const HeightSpace(4),
          Text('Waiting for Organization',
              style: AppStyles.black15BoldStyle
                  .copyWith(color: AppColors.primaryColor)),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1.w),
      ),
      child: Column(
        children: [
          _buildTimelineItem(
              title: 'Request Sent',
              desc: 'Your donation request has been submitted.',
              isCompleted: true,
              isCurrent: false,
              isLast: false),
          _buildTimelineItem(
              title: 'Waiting for Organization',
              desc: 'The organization will review your request.',
              isCompleted: false,
              isCurrent: true,
              isLast: false),
          _buildTimelineItem(
              title: 'Pickup Scheduled',
              desc: 'Pickup time will be confirmed after approval.',
              isCompleted: false,
              isCurrent: false,
              isLast: false),
          _buildTimelineItem(
              title: 'Picked Up',
              desc: 'Your donated clothes have been collected.',
              isCompleted: false,
              isCurrent: false,
              isLast: false),
          _buildTimelineItem(
              title: 'Completed',
              desc: 'Your donation has been successfully completed.',
              isCompleted: false,
              isCurrent: false,
              isLast: true),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
      {required String title,
      required String desc,
      required bool isCompleted,
      required bool isCurrent,
      required bool isLast}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24.h,
          width: 24.w,
          decoration: BoxDecoration(
              color: isCompleted ? AppColors.successColor : null,
              shape: BoxShape.circle,
              border: !isCompleted
                  ? Border.all(
                      width: 1.w,
                      color: isCurrent
                          ? AppColors.primaryColor
                          : AppColors.greyColor)
                  : null),
          child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                      size: 18.sp,
                    )
                  : isCurrent
                      ? Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null),
        ),
        const WidthSpace(16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.productTitleStyle.copyWith(
                    color: (isCompleted || isCurrent)
                        ? AppColors.blackColor
                        : AppColors.greyColor,
                  ),
                ),
                const HeightSpace(4),
                Text(
                  desc,
                  style: AppStyles.productDescriptionStyle.copyWith(
                    color: (isCompleted || isCurrent)
                        ? AppColors.secondaryColor
                        : AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(cubit) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1.w),
      ),
      child: BlocBuilder<DonationCubit, DonationState>(
        builder: (context, state) {
          final clothes = cubit.selectedClothes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Clothes', clothes.formattedSummary),
              const HeightSpace(12),
              _buildDetailRow('Organization', cubit.organizationName),
              const HeightSpace(12),
              _buildDetailRow('Contact', cubit.contactType),
              const HeightSpace(12),
              _buildDetailRow('Pickup', cubit.pickupTime)
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(label, style: AppStyles.grey12MediumStyle),
        ),
        Expanded(
          child: Text(value, style: AppStyles.black16w500Style),
        ),
      ],
    );
  }
}
