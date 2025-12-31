// import 'package:elevate_flower_app/features/home/presentation/view/widgets/category_item.dart';
// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoriesBuilder extends StatelessWidget {
//   const CategoriesBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeStates>(
//       buildWhen: (previous, current) =>
//           previous.categoryState != current.categoryState,
//       builder: (context, state) {
//         return state.categoryState.when(
//           initial: () => const SizedBox.shrink(),

//           loading: () => const Center(child: CircularProgressIndicator()),

//           error: (error) => Center(child: Text(error.toString())),

//           success: (categories) {
//             return ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 return CategoryItem(
//                   imageUrl: category.image,
//                   name: category.name,
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:elevate_flower_app/features/home/presentation/view/widgets/category_item.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({super.key});

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
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryItem(
                    imageUrl: category.image,
                    name: category.name,
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
