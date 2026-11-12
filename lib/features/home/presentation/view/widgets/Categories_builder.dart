import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/home_cubit.dart';
import '../../view_model/cubit/home_states.dart';
import 'category_home_shimmer.dart';
import 'category_item.dart';

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({super.key, this.onSelectedCategory});
  final Function(int? index)? onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          previous.categoryState != current.categoryState,
      builder: (context, state) {
        return state.categoryState.when(
          initial: () => const SizedBox.shrink(),

          loading: () => const CategoryHomeShimmer(),

          error: (error) => Center(child: Text(error.toString())),

          success: (categories) {
            return SizedBox(
              height: 95,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: (index == 0) ? 16 : 0,
                      left: (index == categories.length - 1) ? 16 : 0,
                    ),
                    child: CategoryItem(
                      onTap: () {
                        if (onSelectedCategory == null) return;
                        onSelectedCategory!(index);
                      },
                      imageUrl: categories[index].image,
                      name: categories[index].name,
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
