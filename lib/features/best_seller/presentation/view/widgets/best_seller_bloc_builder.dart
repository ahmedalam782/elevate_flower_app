import '../../../../../core/errors/handle_errors/handle_errors.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_shimmer_grid.dart';
import '../../../../../core/shared/widgets/error_page.dart';
import '../../../../../core/shared/widgets/paginated_product_grid_view.dart';
import '../../view_model/cubit/best_seller_cubit.dart';
import '../../view_model/cubit/best_seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';
import '../../../../cart/presentation/view_model/cubit/cart_events.dart';
import '../../../../cart/presentation/view_model/cubit/cart_states.dart';

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
            return BlocBuilder<CartCubit, CartStates>(
              builder: (context, cartState) {
                return PaginatedProductGridView(
                  products: data.products ?? [],
                  onProductTap: (product) {
                    context.push(Routes.productDetails, extra: product.id);
                  },
                  onAddToCart: (product) {
                    addToCart(context, product.id);
                  },
                  onIncrement: (product) {
                    addToCart(context, product.id);
                  },
                  onDecrement: (product) {
                    final cartProducts =
                        cartState.state.data?.cartProducts ?? [];
                    final itemIndex = cartProducts.indexWhere(
                      (e) => e.id == product.id,
                    );
                    if (itemIndex != -1) {
                      final item = cartProducts[itemIndex];
                      if (item.productQuantityInCart > 1) {
                        context.read<CartCubit>().doIntent(
                          UpdateProductInCartEvent(
                            productId: product.id,
                            qunatity: item.productQuantityInCart,
                          ),
                        );
                      } else {
                        context.read<CartCubit>().doIntent(
                          RemoveProductFromCartEvent(productId: product.id),
                        );
                      }
                    }
                  },
                  onRemove: (product) {
                    context.read<CartCubit>().doIntent(
                      RemoveProductFromCartEvent(productId: product.id),
                    );
                  },
                  getQuantity: (productId) {
                    final cartProducts =
                        cartState.state.data?.cartProducts ?? [];
                    final itemIndex = cartProducts.indexWhere(
                      (e) => e.id == productId,
                    );
                    return itemIndex != -1
                        ? cartProducts[itemIndex].productQuantityInCart
                        : 0;
                  },
                );
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
