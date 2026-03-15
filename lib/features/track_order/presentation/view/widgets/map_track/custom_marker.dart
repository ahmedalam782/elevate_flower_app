import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key, this.imageUrl, required this.label});
  final String? imageUrl;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// label فوق
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primerColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        width: 16,
                        height: 16,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.whiteF9,
                      radius: 8,
                      child: SvgPicture.asset(
                        AppIcons.iconsHome,
                        height: 10,
                        color: AppColors.primerColor,
                      ),
                    ),
              const SizedBox(width: 4),
              Text(label, style: 12.medium.copyWith(color: Colors.white)),
            ],
          ),
        ),

        const SizedBox(height: 6),
        SvgPicture.asset(AppIcons.iconsLocation, height: 25),
      ],
    );
  }
}

class DriverMarker extends StatelessWidget {
  const DriverMarker({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.contain,
      width: 50,
      height: 60,
      errorWidget: (context, url, error) =>
          const Icon(Icons.location_on_rounded),
    );
  }
}
