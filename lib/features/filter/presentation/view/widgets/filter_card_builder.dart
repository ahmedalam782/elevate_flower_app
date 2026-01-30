import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/categories/data/models/product_model/product_dto.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_cubit.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          final products = state.products.products ?? [];

          if (products.isEmpty) {
            return _buildEmptyState();
          }

          return _buildProductsGrid(products, context);
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
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(height: 12, color: Colors.grey[300]),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 100, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(List<ProductDto> products, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        // حساب نسبة الخصم
        final hasDiscount =
            product.priceAfterDiscount != null &&
            product.priceAfterDiscount! < product.price!;
        final discountPercentage = hasDiscount
            ? ((product.price! - product.priceAfterDiscount!) /
                      product.price! *
                      100)
                  .toStringAsFixed(0)
            : '';

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ صورة المنتج
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.grey[100],
                  child: product.imgCover != null
                      ? Image.network(
                          product.imgCover!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                        ),
                ),
              ),

              // ✅ معلومات المنتج

              // ✅ معلومات المنتج
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // اسم المنتج
                      Flexible(
                        child: Text(
                          product.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w100,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

                      // السعر والخصم
                      Row(
                        children: [
                          // السعر الجديد أو السعر العادي
                          Flexible(
                            child: Text(
                              hasDiscount
                                  ? '${product.priceAfterDiscount ?? 0} ج.م'
                                  : '${product.price ?? 0} ج.م',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w100,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // نسبة الخصم
                          if (hasDiscount)
                            Text(
                              '$discountPercentage%',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF4CAF50),
                              ),
                            ),

                          if (hasDiscount) const SizedBox(width: 4),

                          // السعر القديم (مشطوب)
                          if (hasDiscount)
                            Text(
                              '${product.price ?? 0}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                              ),
                            ),

                          if (hasDiscount) const SizedBox(width: 4),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // زر Add to cart
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Add to cart logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E63),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            // LocaleKeys.categories_no_products_found.tr(),
            "غفلبلرلاانتىمة",
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
