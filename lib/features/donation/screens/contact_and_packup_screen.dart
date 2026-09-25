import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/primay_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_state.dart';
import 'package:ecommerce_app/features/address/widgets/address_item_widget.dart';
import 'package:ecommerce_app/features/donation/cubit/donation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
part 'contact_and_packup_screen.g.dart';

@HiveType(typeId: 2)
enum ContactMethod {
  @HiveField(0)
  phoneCall,
  @HiveField(1)
  whatsApp
}

@HiveType(typeId: 3)
enum PickupTime {
  @HiveField(0)
  morning,
  @HiveField(1)
  afternoon,
  @HiveField(2)
  evening
}

class ContactAndPickupScreen extends StatefulWidget {
  const ContactAndPickupScreen({super.key});

  @override
  State<ContactAndPickupScreen> createState() => _ContactAndPickupScreenState();
}

class _ContactAndPickupScreenState extends State<ContactAndPickupScreen> {
  PickupTime _pickupTime = PickupTime.afternoon;
  ContactMethod _contactMethod = ContactMethod.phoneCall;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pickup Details', style: AppStyles.black18BoldStyle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose how we can contact you and where to collect your donation.',
                      style: AppStyles.subtitlesStyles,
                    ),
                    const HeightSpace(24),
                    _buildSectionTitle('Contact Method'),
                    Row(
                      children: [
                        Expanded(
                            child: _buildChoiceCard(
                                title: 'Phone Call',
                                isSelected:
                                    _contactMethod == ContactMethod.phoneCall,
                                onTap: () => setState(() =>
                                    _contactMethod = ContactMethod.phoneCall),
                                icon: Icons.phone_outlined)),
                        const WidthSpace(12),
                        Expanded(
                            child: _buildChoiceCard(
                                title: 'WhatsApp',
                                isSelected:
                                    _contactMethod == ContactMethod.whatsApp,
                                onTap: () => setState(() =>
                                    _contactMethod = ContactMethod.whatsApp),
                                icon: Icons.chat_bubble_outline)),
                      ],
                    ),
                    const HeightSpace(24),
                    _buildSectionTitle('Preferred Pickup Time'),
                    _buildTimeCard(
                      title: 'Morning',
                      time: '8 AM – 12 PM',
                      isSelected: _pickupTime == PickupTime.morning,
                      onTap: () => setState(() {
                        _pickupTime = PickupTime.morning;
                      }),
                    ),
                    const HeightSpace(12),
                    _buildTimeCard(
                      title: 'Afternoon',
                      time: '12 PM – 4 PM',
                      isSelected: _pickupTime == PickupTime.afternoon,
                      onTap: () =>
                          setState(() => _pickupTime = PickupTime.afternoon),
                    ),
                    const HeightSpace(12),
                    _buildTimeCard(
                      title: 'Evening',
                      time: '4 PM – 8 PM',
                      isSelected: _pickupTime == PickupTime.evening,
                      onTap: () =>
                          setState(() => _pickupTime = PickupTime.evening),
                    ),
                    const HeightSpace(24),
                    _buildSectionTitle('Pickup Address'),
                    _buildAddressCard(),
                    const HeightSpace(16),
                  ],
                ),
              ),
            ),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(title, style: AppStyles.black15BoldStyle),
    );
  }

  Widget _buildChoiceCard(
      {required String title,
      required bool isSelected,
      required VoidCallback onTap,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor,
                size: 24.w),
            SizedBox(height: 8.h),
            Text(title,
                style: AppStyles.productTitleStyle.copyWith(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.blackColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard(
      {required String title,
      required String time,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyles.productTitleStyle),
                SizedBox(height: 4.h),
                Text(time, style: AppStyles.productDescriptionStyle),
              ],
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return BlocBuilder<UserInfoCubit, UserInfoState>(builder: (context, state) {
      if (state is UserInfoLoadingState) {
        return const Center(
            child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ));
      }
      if (state is UserInfoErrorState) {
        return Center(child: Text(state.errorMessage));
      }
      if (state is UserInfoLoadedState) {
        if (state.userModel.address != null) {
          final addressModel = state.userModel.address!;
          return Column(
            children: [
              AddressItemWidget(
                addressModel: addressModel,
              ),
              const HeightSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Use this address', style: AppStyles.grey12MediumStyle),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0)),
                    child: Text('Change Address',
                        style: AppStyles.productTitleStyle
                            .copyWith(color: AppColors.primaryColor)),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Center(
              child: Text(
            'No address found.',
            style: AppStyles.grey12MediumStyle,
          ));
        }
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildContinueButton() {
    return PrimaryButtonWidget(
        buttonText: 'Continue',
        onPress: () {
          final contactPhone = _contactMethod == ContactMethod.phoneCall
              ? 'Phone Call'
              : 'WhatsApp';
          final pickupTime = _pickupTime == PickupTime.morning
              ? 'Morning'
              : _pickupTime == PickupTime.afternoon
                  ? 'Afternoon'
                  : 'Evening';
          context
              .read<DonationCubit>()
              .setContactPhoneAndPicupTime(contactPhone, pickupTime);

          context.pushNamed(AppRoutes.donationTrackingScreen,
              extra: context.read<DonationCubit>());
        });
  }
}
