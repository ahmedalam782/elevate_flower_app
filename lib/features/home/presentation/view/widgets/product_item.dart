import '../../../../../core/shared/widgets/optimized_cached_image.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int? price;
  final VoidCallback? onTap;

  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.name,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: OptimizedCachedImage(
                  imageUrl: imageUrl,
                  height: 130.h,
                  fit: BoxFit.cover,
                  // width: ,
                ),

                // Image.network(
                //   imageUrl,
                //   height: 130,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.black0C,
              ),
            ),
            const SizedBox(height: 4),
            if (price != null)
              Text(
                '$price EGP',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
