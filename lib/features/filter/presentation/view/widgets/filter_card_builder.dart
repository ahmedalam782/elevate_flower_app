import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_item.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_cubit.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FilterCardBuilder extends StatelessWidget {
  const FilterCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return _buildLoadingGrid();
        }

        if (state is FilterLoaded) {
          final productsDto = state.products.products ?? [];

          if (productsDto.isEmpty) {
            return _buildEmptyState();
          }

          // Convert ProductDto to ProductItemEntity
          final products = productsDto.map((dto) {
            return ProductItemEntity(
              id: dto.id ?? '',
              name: dto.title,
              price: dto.price?.toDouble(),
              imageUrl: dto.imgCover,
              priceAfterDiscount: dto.priceAfterDiscount?.toDouble(),
            );
          }).toList();

          return BlocBuilder<CartCubit, CartStates>(
            builder: (context, cartState) {
              return _buildProductsGrid(context, products, cartState);
            },
          );
        }

        if (state is FilterError) {
          return _buildErrorState(state.message);
        }

        return _buildEmptyState();
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
      itemCount: 6,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.products_no_products.tr(),
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: AppColors.redCC),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: AppColors.redCC),
          ),
        ],
      ),
    );
  }
}
