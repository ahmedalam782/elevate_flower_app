import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/product_item.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BestsellerBuilder extends StatelessWidget {
  const BestsellerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, curr) => prev.bestSellerState != curr.bestSellerState,
      builder: (context, state) {
        return state.bestSellerState.when(
          initial: () => const SizedBox.shrink(),

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (error) => Center(child: Text(error.toString())),

          success: (products) {
            return SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = products[index];

                  return ProductItem(
                    onTap: () {
                      context.push(Routes.productDetails, extra: item.id);
                    },
                    imageUrl: item.imgCover,
                    name: item.title,
                    price: item.price,
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
