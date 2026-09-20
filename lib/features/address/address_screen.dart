import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_cubit.dart';
import 'package:ecommerce_app/features/address/cubit/user_info_state.dart';
import 'package:ecommerce_app/features/address/widgets/address_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserInfoCubit>().getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const HeightSpace(20),
            Text('Saved Address', style: AppStyles.black15BoldStyle),
            const HeightSpace(24),
            BlocBuilder<UserInfoCubit, UserInfoState>(builder: (context, state) {
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
                  return AddressItemWidget(
                    addressModel: state.userModel.address!,
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
            })
          ],
        ),
      ),
    );
  }
}
