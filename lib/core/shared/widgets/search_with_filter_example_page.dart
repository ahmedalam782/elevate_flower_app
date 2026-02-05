import 'package:easy_localization/easy_localization.dart';
import '../entities/product_item_entity.dart';
import 'custom_product_grid_view.dart';
import 'custom_search_with_filter.dart';
import 'custom_tab_bar.dart';
import 'filter_bottom_sheet.dart';
import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../languages/locale_keys.g.dart';

/// Complete example page with search, tabs, pagination, and cart
class SearchWithFilterExamplePage extends StatefulWidget {
  const SearchWithFilterExamplePage({super.key});

  @override
  State<SearchWithFilterExamplePage> createState() =>
      _SearchWithFilterExamplePageState();
}

class _SearchWithFilterExamplePageState
    extends State<SearchWithFilterExamplePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _productScrollController = ScrollController();
  final ScrollController _tabScrollController = ScrollController();

  // Categories/Tabs
  final List<String> _categories = [
    'All',
    'Roses',
    'Tulips',
    'Orchids',
    'Sunflowers',
    'Lilies',
    'Daisies',
    'Carnations',
  ];
  int _selectedCategoryIndex = 0;
  bool _isLoadingCategories = false;

  // Products
  List<ProductItemEntity> _allProducts = [];
  List<ProductItemEntity> _filteredProducts = [];
  bool _isLoadingProducts = false;
  bool _isLoadingMoreProducts = false;
  int _currentPage = 1;
  final int _productsPerPage = 10;
  bool _hasMoreProducts = true;

  // Search & Filter
  String _searchQuery = '';
  SortOption? _selectedSort;

  // Cart
  final Map<String, int> _cartQuantities = {};

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _productScrollController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoadingCategories = true;
      _isLoadingProducts = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Generate mock products
    _allProducts = _generateMockProducts(50);
    _applyFilters();

    setState(() {
      _isLoadingCategories = false;
      _isLoadingProducts = false;
    });
  }

  List<ProductItemEntity> _generateMockProducts(int count) {
    final categories = ['Roses', 'Tulips', 'Orchids', 'Sunflowers', 'Lilies'];
    return List.generate(count, (index) {
      final category = categories[index % categories.length];
      return ProductItemEntity(
        id: 'product_$index',
        name: '$category ${index + 1}',
        description: 'Beautiful $category flowers',
        price: 500.0 + (index * 50),
        priceAfterDiscount: index % 3 == 0 ? 400.0 + (index * 40) : null,
        imageUrl: 'https://via.placeholder.com/300x300',
      );
    });
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMoreProducts) return;

    setState(() {
      _isLoadingMoreProducts = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _currentPage++;
      _isLoadingMoreProducts = false;
      _applyFilters();
    });
  }

  void _onSearchChanged(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      _currentPage = 1;
      _applyFilters();
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _currentPage = 1;
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

    // Apply category filter
    if (_selectedCategoryIndex > 0) {
      final selectedCategory = _categories[_selectedCategoryIndex];
      filtered = filtered
          .where(
            (product) =>
                product.name?.toLowerCase().contains(
                  selectedCategory.toLowerCase(),
                ) ??
                false,
          )
          .toList();
    }

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

    // Apply pagination
    final totalFiltered = filtered.length;
    final endIndex = (_currentPage * _productsPerPage).clamp(0, totalFiltered);

    setState(() {
      _filteredProducts = filtered.take(endIndex).toList();
      _hasMoreProducts = endIndex < totalFiltered;
    });
  }

  void _showFilterSheet() {
    showFilterBottomSheet(
      context: context,
      selectedSort: _selectedSort,
      onApplyFilter: _onFilterApplied,
    );
  }

  int get _totalCartItems =>
      _cartQuantities.values.fold(0, (sum, qty) => sum + qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: AppColors.primerColor,
        foregroundColor: AppColors.whiteFF,
        actions: [
          // Cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cart has $_totalCartItems items'),
                      backgroundColor: AppColors.primerColor,
                    ),
                  );
                },
              ),
              if (_cartQuantities.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.redCC,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_totalCartItems',
                      style: const TextStyle(
                        color: AppColors.whiteFF,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar with Filter
          Padding(
            padding: EdgeInsets.all(16.w),
            child: CustomSearchWithFilter(
              hintText: LocaleKeys.products_search.tr(),
              controller: _searchController,
              onSearchChanged: _onSearchChanged,
              onFilterTap: _showFilterSheet,
              showFilter: true,
            ),
          ),

          // Active Filter Chip
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

          Gap(8.h),

          // Category Tabs
          CustomTabBar(
            tabList: _categories,
            selectedIndex: _selectedCategoryIndex,
            onSelectedItem: _onCategorySelected,
            isInitialLoading: _isLoadingCategories,
            scrollController: _tabScrollController,
          ),

          Gap(8.h),

          // Products Grid
          Expanded(
            child: CustomProductGridView(
              products: _filteredProducts,
              isLoading: _isLoadingProducts,
              hasMore: _hasMoreProducts,
              onLoadMore: _loadMoreProducts,
              scrollController: _productScrollController,
              getQuantity: (productId) => _cartQuantities[productId] ?? 0,
              onProductTap: (product) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped ${product.name}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              onAddToCart: (product) {
                setState(() {
                  _cartQuantities[product.id] = 1;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    backgroundColor: AppColors.green0C,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              onIncrement: (product) {
                setState(() {
                  _cartQuantities[product.id] =
                      (_cartQuantities[product.id] ?? 0) + 1;
                });
              },
              onDecrement: (product) {
                setState(() {
                  final currentQty = _cartQuantities[product.id] ?? 0;
                  if (currentQty > 1) {
                    _cartQuantities[product.id] = currentQty - 1;
                  }
                });
              },
              onRemove: (product) {
                setState(() {
                  _cartQuantities.remove(product.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} removed from cart'),
                    backgroundColor: AppColors.redCC,
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
