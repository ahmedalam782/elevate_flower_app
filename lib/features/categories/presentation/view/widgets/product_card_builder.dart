import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_item.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductCardBuilder extends StatelessWidget {
  const ProductCardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoriesCubit, CategoriesStates>(
        builder: (context, state) {
          return state.productsOfCategory.when(
            initial: () => Center(
              child: Text(LocaleKeys.categories_select_a_category.tr()),
            ),
            loading: () => _buildLoadingGrid(),
            success: (products) => _buildProductsGrid(products),
            error: (exception) => Center(
              child: Text(
                LocaleKeys.categories_error_loading_products.tr(),
                style: const TextStyle(color: AppColors.redCC),
              ),
            ),
          );
        },
      ),
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

  Widget _buildProductsGrid(List<ProductEntity> products) {
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
        return CustomProductItem(
          product: _mapToProductItemEntity(product),
          onTap: () {
            // Navigate to product details
            context.push(Routes.productDetails, extra: product.id);
          },
          onAddToCart: () {
            // Add to cart logic
          },
          quantity: 0, // You can get this from cart state
        );
      },
    );
  }

  // Map ProductEntity to ProductItemEntity
  ProductItemEntity _mapToProductItemEntity(ProductEntity product) {
    return ProductItemEntity(
      id: product.id,
      name: product.title,
      description: product.description,
      price: product.price,
      priceAfterDiscount: product.priceAfterDiscount,
      imageUrl: product.imgCover,
    );
  }
}
