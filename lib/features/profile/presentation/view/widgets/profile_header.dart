import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/theme/app_icons.dart';

/// Profile header widget showing user avatar, name, and email
class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String email;
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    this.imageUrl,
    required this.name,
    required this.email,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          // Profile Image with edit icon
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primerColor.withValues(alpha: 0.2),
                    width: 2.w,
                  ),
                ),
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.pinkF9,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primerColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return _buildPlaceholderAvatar();
                          },
                        )
                      : _buildPlaceholderAvatar(),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: 18.semiBold.copyWith(color: AppColors.black32)),
              const SizedBox(width: 8),
              if (onEditTap != null)
                InkWell(
                  onTap: onEditTap,
                  child: SvgPicture.asset(
                    AppIcons.iconsEditProfile,
                    fit: BoxFit.scaleDown,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          // Email
          Text(email, style: 14.regular.copyWith(color: AppColors.black85)),
        ],
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      color: AppColors.pinkF9,
      child: Icon(Icons.person, size: 50.sp, color: AppColors.primerColor),
    );
  }
}
