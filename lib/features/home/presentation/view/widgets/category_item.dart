import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String? imageUrl;
  final String? name;

  const CategoryItem({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.network(
              imageUrl ?? '',
              width: 35,
              height: 35,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 35,
                  color: Colors.pink[200],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name ?? '',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}




// Column(
//       children: [
//         // Square container with rounded corners
//         Container(
//           width: 70,
//           height: 70,
//           decoration: BoxDecoration(
//             color: Colors.pink[50],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Center(
//             child: Image.network(
//               imageUrl ?? '',
//               width: 35,
//               height: 35,
//               fit: BoxFit.contain,
//               errorBuilder: (context, error, stackTrace) {
//                 return Icon(
//                   Icons.image_not_supported,
//                   size: 35,
//                   color: Colors.pink[200],
//                 );
//               },
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           name ?? '',
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );