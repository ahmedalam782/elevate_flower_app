import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerContainerV2 extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final double? radius;
  final Widget? child;
  const CustomShimmerContainerV2({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.width,
    this.height,
    this.radius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
        ),
        child: child,
      ),
    );
  }
}
