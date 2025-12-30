import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          previous.categoryState != current.categoryState,
      builder: (context, state) {
        return state.categoryState.when(
          initial: () => const SizedBox.shrink(),

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error) => Center(child: Text(error.toString())),

          success: (categories) {
            return SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(vertical: 8),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return SizedBox(
                    width: 90,
                    child: Column(
                      children: [
                        // Square container with rounded corners
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Image.network(
                              category.image ?? '',
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
                          category.name ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoriesWidget extends StatelessWidget {
//   const CategoriesWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeStates>(
//       buildWhen: (previous, current) =>
//           previous.categoryState != current.categoryState,
//       builder: (context, state) {
//         return state.categoryState.when(
//           initial: () => const SizedBox.shrink(),

//           loading: () => const Center(
//             child: CircularProgressIndicator(),
//           ),

//           error: (error) => Center(
//             child: Text(error.toString()),
//           ),

//           success: (categories) {
//             return SizedBox(
//               height: 100,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categories.length,
//                 separatorBuilder: (_, __) =>
//                     const SizedBox(width: 12),
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage:
//                             NetworkImage(category.image ?? ''),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(category.name ?? ''),
//                     ],
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
