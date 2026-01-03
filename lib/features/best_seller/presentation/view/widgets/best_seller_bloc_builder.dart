import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_shimmer_grid.dart';
import 'package:elevate_flower_app/core/shared/widgets/error_page.dart';
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BestSellerBlocBuilder extends StatelessWidget {
  const BestSellerBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerStates>(
      buildWhen: (previous, current) =>
          previous.getMostSellerState != current.getMostSellerState,
      builder: (context, state) {
        return state.getMostSellerState.when(
          initial: () {
            return const Center(child: CustomShimmerGrid());
          },
          loading: () {
            return const Center(child: CustomShimmerGrid());
          },
          success: (data) {
            return PaginatedProductGridView(
              products: data.products ?? [],
              onProductTap: (product) {
                context.push(Routes.productDetails, extra: product.id);
              },
            );
          },
          error: (exception) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ErrorPage(
                message: handleError(exception),
                isScrollable: false,
              ),
            );
          },
        );
      },
    );
  }
}
