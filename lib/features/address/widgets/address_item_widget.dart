import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/address/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressItemWidget extends StatelessWidget {
  final AddressModel addressModel;
  const AddressItemWidget({super.key, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    final String addressDetails =
        '${addressModel.address}, ${addressModel.city}, ${addressModel.state} (${addressModel.postalCode})';

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.place_outlined,
              color: Colors.grey.shade700,
              size: 28.sp,
            ),
            const WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressModel.country,
                    style: AppStyles.black15BoldStyle,
                  ),
                  const HeightSpace(4),
                  Text(
                    addressDetails,
                    style: AppStyles.grey12MediumStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
