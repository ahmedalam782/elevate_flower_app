import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shared/widgets/optimized_cached_image.dart';

class CategoryItem extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          children: [
            Container(
              width: 68,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.pinkF9,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: OptimizedCachedImage(
                  imageUrl: imageUrl ?? '',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                name ?? '',
                style: 14.regular.copyWith(height: 1),
                maxLines: 2,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
