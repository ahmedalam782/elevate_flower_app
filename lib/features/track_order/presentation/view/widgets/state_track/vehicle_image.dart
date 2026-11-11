import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VehicleImage extends StatelessWidget {
  const VehicleImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 83,
      child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
    );
  }
}
