import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_icons.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    this.width=double.infinity,
    this.height=double.infinity,
    required this.imagePath,
    this.fit= BoxFit.contain,
    this.emptyColorFilter,
    this.color,
  });

  final double? width, height;
  final String imagePath;
  final ColorFilter? emptyColorFilter;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    if (imagePath.isEmpty) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? AppColors.pinkF9,
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.iconsNoImage,
            fit: BoxFit.contain,
            colorFilter:
                emptyColorFilter ??
                const ColorFilter.mode(AppColors.primerColor, BlendMode.srcIn),
          ),
        ),
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      imageUrl: imagePath,
      color: color,
      fadeInDuration: const Duration(milliseconds: 500),
      errorListener: (value) {
        log('Error loading image: $value');
      },
      errorWidget: (context, url, error) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.pinkF9,
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcons.iconsNoImage,
            fit: BoxFit.scaleDown,
            width: width,
            height: height,
            colorFilter:
                emptyColorFilter ??
                const ColorFilter.mode(AppColors.primerColor, BlendMode.srcIn),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.pinkF9,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CircularProgressIndicator(
            value: progress.progress,
            color: AppColors.primerColor,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
