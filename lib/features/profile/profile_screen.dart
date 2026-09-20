import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserInfoCubit>().getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: AppStyles.primaryHeadLinesStyle.copyWith(fontSize: 25.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is UserInfoErrorState) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is UserInfoLoadedState) {
            final user = state.userModel;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: NetworkImage(user.image),
                        ),
                        const HeightSpace(12),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: AppStyles.black15BoldStyle
                              .copyWith(fontSize: 18.sp),
                        ),
                        const HeightSpace(4),
                        Text(
                          '@${user.username}',
                          style: AppStyles.grey12MediumStyle,
                        ),
                      ],
                    ),
                  ),
                  const HeightSpace(24),
                  const Divider(),
                  const HeightSpace(16),
                  _ProfileInfoTile(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: user.email,
                  ),
                  _ProfileInfoTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: user.phone,
                  ),
                  if (user.address != null)
                    _ProfileInfoTile(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: '${user.address!.address}, ${user.address!.city}',
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// Widget إعادة استخدام لصفوف البيانات
class _ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 22.sp),
          const WidthSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.grey12MediumStyle),
              const HeightSpace(2),
              Text(
                value,
                style: AppStyles.black15BoldStyle.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
