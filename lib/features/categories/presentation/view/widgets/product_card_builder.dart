import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/entities/product_item_entity.dart';
import '../../../../../core/shared/widgets/custom_product_item.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../view_model/cubit/categories_cubit.dart';
import '../../view_model/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';
import '../../../../cart/presentation/view_model/cubit/cart_events.dart';
import '../../../../cart/presentation/view_model/cubit/cart_states.dart';

import 'package:go_router/go_router.dart';

class ProductCardBuilder extends StatelessWidget {
  const ProductCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        return state.productsOfCategory.when(
          initial: () =>
              Center(child: Text(LocaleKeys.categories_select_a_category.tr())),
          loading: () => _buildLoadingGrid(),
          success: (products) {
            return BlocBuilder<CartCubit, CartStates>(
              builder: (context, cartState) {
                return _buildProductsGrid(context, products, cartState);
              },
            );
          },
          error: (exception) => Center(
            child: Text(
              LocaleKeys.categories_error_loading_products.tr(),
              style: const TextStyle(color: AppColors.redCC),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6, // Show 6 shimmer items
      itemBuilder: (context, index) {
        return const CustomProductItem(
          product: ProductItemEntity(id: ''),
          isLoading: true,
        );
      },
    );
  }

  Widget _buildProductsGrid(
    BuildContext context,
    List<ProductItemEntity> products,
    CartStates cartState,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final cartProducts = cartState.state.data?.cartProducts ?? [];
        final itemIndex = cartProducts.indexWhere((e) => e.id == product.id);
        final quantity = itemIndex != -1
            ? cartProducts[itemIndex].productQuantityInCart
            : 0;

        return CustomProductItem(
          product: product,
          quantity: quantity,
          onTap: () {
            context.push(Routes.productDetails, extra: product.id);
          },
          onAddToCart: () {
            addToCart(context, product.id);
          },
          onIncrement: () {
            addToCart(context, product.id);
          },
          onDecrement: () {
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
          onRemove: () {
            context.read<CartCubit>().doIntent(
              RemoveProductFromCartEvent(productId: product.id),
            );
          },
        );
      },
    );
  }
}
