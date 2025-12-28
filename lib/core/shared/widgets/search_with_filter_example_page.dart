import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_grid_view.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_search_with_filter.dart';
import 'package:elevate_flower_app/core/shared/widgets/filter_bottom_sheet.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../languages/locale_keys.g.dart';

/// Example page demonstrating the custom search with filter
class SearchWithFilterExamplePage extends StatefulWidget {
  const SearchWithFilterExamplePage({super.key});

  @override
  State<SearchWithFilterExamplePage> createState() =>
      _SearchWithFilterExamplePageState();
}

class _SearchWithFilterExamplePageState
    extends State<SearchWithFilterExamplePage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductItemEntity> _allProducts = [];
  List<ProductItemEntity> _filteredProducts = [];
  bool _isLoading = false;
  String _searchQuery = '';
  SortOption? _selectedSort;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Generate mock products
    final products = List.generate(20, (index) {
      return ProductItemEntity(
        id: 'product_$index',
        name: 'Red Roses ${index + 1}',
        description: 'Beautiful red roses',
        price: 500.0 + (index * 50),
        priceAfterDiscount: index % 3 == 0 ? 400.0 + (index * 40) : null,
        imageUrl: 'https://via.placeholder.com/300x300',
      );
    });

    setState(() {
      _allProducts = products;
      _filteredProducts = products;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      _applyFilters();
    });
  }

  void _onFilterApplied(SortOption? sortOption) {
    setState(() {
      _selectedSort = sortOption;
      _applyFilters();
    });
  }

  void _applyFilters() {
    var filtered = _allProducts;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (product) =>
                product.name?.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ??
                false,
          )
          .toList();
    }

    // Apply sort
    if (_selectedSort != null) {
      switch (_selectedSort!) {
        case SortOption.lowestPrice:
          filtered.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
          break;
        case SortOption.highestPrice:
          filtered.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
          break;
        case SortOption.newest:
          // Reverse order for newest
          filtered = filtered.reversed.toList();
          break;
        case SortOption.oldest:
          // Keep original order
          break;
        case SortOption.discount:
          filtered = filtered
              .where(
                (p) =>
                    p.priceAfterDiscount != null &&
                    p.priceAfterDiscount! < (p.price ?? 0),
              )
              .toList();
          break;
      }
    }

    setState(() {
      _filteredProducts = filtered;
    });
  }

  void _showFilterSheet() {
    showFilterBottomSheet(
      context: context,
      selectedSort: _selectedSort,
      onApplyFilter: _onFilterApplied,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: AppBar(
        title: const Text('Search & Filter Example'),
        backgroundColor: AppColors.primerColor,
        foregroundColor: AppColors.whiteFF,
      ),
      body: Column(
        children: [
          // Search Bar with Filter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchWithFilter(
              title: LocaleKeys.custom_widgets_search.tr(),
              controller: _searchController,
              onSearchChanged: _onSearchChanged,
              onFilterTap: _showFilterSheet,
              showFilter: true,
            ),
          ),

          Gap(8.h),

          // Active Filter Chip (if any)
          if (_selectedSort != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Chip(
                  label: Text(_getSortLabel(_selectedSort!)),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () {
                    setState(() {
                      _selectedSort = null;
                      _applyFilters();
                    });
                  },
                  backgroundColor: AppColors.pinkF9,
                  labelStyle: TextStyle(
                    color: AppColors.primerColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),

          // Products Grid
          Expanded(
            child: CustomProductGridView(
              products: _filteredProducts,
              isLoading: _isLoading,
              hasMore: false,
              onProductTap: (product) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped ${product.name}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              onAddToCart: (product) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    backgroundColor: AppColors.green0C,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.lowestPrice:
        return LocaleKeys.products_lowest_price.tr();
      case SortOption.highestPrice:
        return LocaleKeys.products_highest_price.tr();
      case SortOption.newest:
        return LocaleKeys.products_new.tr();
      case SortOption.oldest:
        return LocaleKeys.products_old.tr();
      case SortOption.discount:
        return LocaleKeys.products_discount.tr();
    }
  }
}
