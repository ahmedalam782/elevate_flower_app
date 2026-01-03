import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/category_home_shimmer.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/product_item.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OccasionWidget extends StatelessWidget {
  const OccasionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, curr) => prev.occasionState != curr.occasionState,
      builder: (context, state) {
        return state.occasionState.when(
          initial: () => const SizedBox.shrink(),

          loading: () => const CategoryHomeShimmer(),

          error: (error) => Center(child: Text(error.toString())),

          success: (occasions) {
            return SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: occasions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final occasion = occasions[index];
                  return ProductItem(
                    imageUrl: occasion.image,
                    name: occasion.name,
                    onTap: () {
                      context.push(Routes.occasions, extra: index);
                    },
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
