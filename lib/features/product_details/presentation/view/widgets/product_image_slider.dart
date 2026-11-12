import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/shared/widgets/product_hero.dart';
import 'image_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;
  final String? productId;
  const ProductImageSlider({super.key, required this.images, this.productId});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 1.sw,
          child: PageView.builder(
            onPageChanged: (index) {
              currentIndex = index;
              // print(index);
              setState(() {});
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final image = CachedNetworkImage(
                imageUrl: widget.images[index],
                width: 1.sw,
                height: 450.h,
                fit: BoxFit.cover,
              );
              if (index == 0 && widget.productId != null) {
                return Hero(
                  tag: productHeroTag(widget.productId!),
                  child: image,
                );
              }
              return image;
            },
          ),
        ),

        // Positioned(
        //   top: 70.h,
        //   left: 16.w,
        //   child: Transform.scale(
        //     scale: 1.5,
        //     child: InkWell(
        //       onTap: () {
        //         if (context.canPop()) {
        //           context.pop();
        //         }
        //       },
        //       child: Icon(Icons.chevron_left),
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 24.h,
          child: Align(
            alignment: AlignmentGeometry.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.images.length, (index) {
                  return ImageDotIndicator(isCurrent: currentIndex == index);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// final String dummyImageLink =
//     "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
