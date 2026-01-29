import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressCell extends StatelessWidget {
  const AddressCell({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.address,
  });
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final UserAddressEntity? address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray53.withValues(alpha: 0.25),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.iconsLocation,
                width: 20.w,
                height: 20.h,
              ),
              const SizedBox(width: 4),
              Text(
                address?.city ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onDelete,
                child: SvgPicture.asset(
                  AppIcons.iconsDelete,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  AppIcons.iconsEditProfile,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "${address?.street} - ${address?.city}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.gray53,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

