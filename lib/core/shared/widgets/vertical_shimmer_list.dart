import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalShimmerList extends StatelessWidget {
  const VerticalShimmerList({
    super.key,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.baseColor,
    this.highlightColor,
  });

  final double height;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: SizedBox(
        width: height,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
