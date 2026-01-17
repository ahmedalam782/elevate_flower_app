import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerGrid extends StatelessWidget {
  const CustomShimmerGrid({
    super.key,
    this.length = 6,
    this.itemHeight = 120,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.childAspectRatio = 0.75,
    this.shrinkWrap = false,
  });

  final int length;
  final double itemHeight;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return CustomShimmerContainer(
          height: itemHeight,
          width: double.infinity,
          borderRadius: 12,
        );
      },
    );
  }
}


class CustomShimmerContainer extends StatelessWidget {
  const CustomShimmerContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 12,
  });
  final double height, width, borderRadius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}