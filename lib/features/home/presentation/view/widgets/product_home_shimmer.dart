import 'package:elevate_flower_app/core/shared/widgets/horizontal_shimmer_list.dart';
import 'package:flutter/material.dart';

class ProductHomeShimmer extends StatelessWidget {
  const ProductHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalShimmerList(
      height: 220,
      itemCount: 5,
      itemBuilder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 12, width: 120, color: Colors.grey),
            const SizedBox(height: 6),
            Container(height: 12, width: 80, color: Colors.grey),
          ],
        );
      },
    );
  }
}
