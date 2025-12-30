import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (prev, curr) =>
          prev.bestSellerState != curr.bestSellerState,
      builder: (context, state) {
        return state.bestSellerState.when(
          initial: () => const SizedBox.shrink(),

          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),

          error: (error) => Center(
            child: Text(error.toString()),
          ),

          success: (products) {
            return SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = products[index];
                  return SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            item.imgCover ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item.title ?? ''),
                        Text('${item.price} EGP'),
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
