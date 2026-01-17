import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OptimizedCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData shimmerIcon;
  final Duration fadeDuration;
  final double loadingIconSize;

  const OptimizedCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.shimmerIcon = Icons.image,
    this.fadeDuration = const Duration(milliseconds: 400),
    this.loadingIconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pixelRatio = MediaQuery.of(context).devicePixelRatio;
          final targetWidth = (constraints.maxWidth * pixelRatio).toInt();
          final targetHeight = (constraints.maxHeight * pixelRatio).toInt();

          Widget image = CachedNetworkImage(
            imageUrl: imageUrl,
            memCacheWidth: targetWidth,
            memCacheHeight: targetHeight,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => _buildShimmerPlaceholder(context),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image),
            // 👇 Add fade-in animation when image loads
            imageBuilder: (context, imageProvider) => AnimatedSwitcher(
              duration: fadeDuration,
              child: Container(
                key: ValueKey(imageUrl),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit,
                  ),
                ),
              ),
            ),
          );

          if (borderRadius != null) {
            image = ClipRRect(
              borderRadius: borderRadius!,
              child: image,
            );
          }

          return SizedBox(
            width: width,
            height: height,
            child: image,
          );
        },
      ),
    );
  }

  Widget _buildShimmerPlaceholder(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: Icon(
          shimmerIcon,
          size: loadingIconSize,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
