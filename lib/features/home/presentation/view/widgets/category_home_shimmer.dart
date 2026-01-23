import 'package:elevate_flower_app/core/shared/widgets/horizontal_shimmer_list.dart';
import 'package:flutter/material.dart';

class CategoryHomeShimmer extends StatelessWidget {
  const CategoryHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalShimmerList(
      height: 100,
      itemCount: 6,
      itemBuilder: (_, __) {
        return Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 10, width: 50, color: Colors.grey),
          ],
        );
      },
    );
  }
}
