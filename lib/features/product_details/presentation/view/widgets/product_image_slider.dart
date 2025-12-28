import 'package:cached_network_image/cached_network_image.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view/widgets/image_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key});

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
          height: 450.h,
          child: PageView.builder(
            onPageChanged: (index) {
              currentIndex = index;
              print(index);
              setState(() {});
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              print(images[index]);
              return CachedNetworkImage(
                imageUrl: images[index],
                width: 1.sw,
                height: 450.h,
                fit: BoxFit.cover,
              );
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
                children: List.generate(images.length, (index) {
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

List<String> images = [
  "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
];

// final String dummyImageLink =
//     "https://images.unsplash.com/photo-1471899236350-e3016bf1e69e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
