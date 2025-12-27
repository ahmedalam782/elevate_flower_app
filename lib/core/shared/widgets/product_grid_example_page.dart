import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_grid_view.dart';
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Example page demonstrating how to use the custom product grid widgets
///
/// This file shows two approaches:
/// 1. Infinite scroll pagination (CustomProductGridView)
/// 2. Page number pagination (PaginatedProductGridView)
class ProductGridExamplePage extends StatefulWidget {
  const ProductGridExamplePage({super.key});

  @override
  State<ProductGridExamplePage> createState() => _ProductGridExamplePageState();
}

class _ProductGridExamplePageState extends State<ProductGridExamplePage> {
  // For infinite scroll example
  List<ProductItemEntity> _infiniteScrollProducts = [];
  bool _isLoadingInfinite = false;
  bool _hasMoreInfinite = true;
  int _infiniteScrollPage = 1;

  // For paginated example
  List<ProductItemEntity> _paginatedProducts = [];
  bool _isLoadingPaginated = false;
  int _currentPage = 1;
  int _totalPages = 10;
  final int _itemsPerPage = 10;

  // Toggle between examples
  bool _showInfiniteScroll = true;

  @override
  void initState() {
    super.initState();
    _loadInfiniteScrollProducts();
    _loadPaginatedProducts(_currentPage);
  }

  // Simulate loading products for infinite scroll
  Future<void> _loadInfiniteScrollProducts() async {
    if (_isLoadingInfinite || !_hasMoreInfinite) return;

    setState(() {
      _isLoadingInfinite = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Generate mock products
    final newProducts = List.generate(10, (index) {
      final productIndex = (_infiniteScrollPage - 1) * 10 + index + 1;
      return ProductItemEntity(
        id: 'product_$productIndex',
        name: 'Red Roses',
        description: 'Beautiful red roses',
        price: 800.0,
        priceAfterDiscount: 600.0,
        imageUrl: 'https://via.placeholder.com/300x300',
      );
    });

    setState(() {
      _infiniteScrollProducts.addAll(newProducts);
      _infiniteScrollPage++;
      _isLoadingInfinite = false;
      // Simulate having only 5 pages
      _hasMoreInfinite = _infiniteScrollPage <= 5;
    });
  }

  // Simulate loading products for paginated view
  Future<void> _loadPaginatedProducts(int page) async {
    setState(() {
      _isLoadingPaginated = true;
      _currentPage = page;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Generate mock products for the current page
    final newProducts = List.generate(_itemsPerPage, (index) {
      final productIndex = (page - 1) * _itemsPerPage + index + 1;
      return ProductItemEntity(
        id: 'product_$productIndex',
        name: 'Red Roses',
        description: 'Beautiful red roses',
        price: 800.0,
        priceAfterDiscount: 600.0,
        imageUrl: 'https://via.placeholder.com/300x300',
      );
    });

    setState(() {
      _paginatedProducts = newProducts;
      _isLoadingPaginated = false;
    });
  }

  void _onProductTap(ProductItemEntity product) {
    // Navigate to product details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on ${product.name}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onAddToCart(ProductItemEntity product) {
    // Add product to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        backgroundColor: AppColors.green0C,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showInfiniteScroll ? 'Infinite Scroll Grid' : 'Paginated Grid',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primerColor,
        foregroundColor: AppColors.whiteFF,
        actions: [
          // Toggle button
          IconButton(
            icon: Icon(
              _showInfiniteScroll ? Icons.grid_view : Icons.view_agenda,
            ),
            onPressed: () {
              setState(() {
                _showInfiniteScroll = !_showInfiniteScroll;
              });
            },
            tooltip: 'Switch view',
          ),
        ],
      ),
      body: _showInfiniteScroll
          ? _buildInfiniteScrollView()
          : _buildPaginatedView(),
    );
  }

  Widget _buildInfiniteScrollView() {
    return CustomProductGridView(
      products: _infiniteScrollProducts,
      isLoading: _isLoadingInfinite,
      hasMore: _hasMoreInfinite,
      onLoadMore: _loadInfiniteScrollProducts,
      onProductTap: _onProductTap,
      onAddToCart: _onAddToCart,
    );
  }

  Widget _buildPaginatedView() {
    return PaginatedProductGridView(
      products: _paginatedProducts,
      isLoading: _isLoadingPaginated,
      currentPage: _currentPage,
      totalPages: _totalPages,
      onPageChanged: _loadPaginatedProducts,
      onProductTap: _onProductTap,
      onAddToCart: _onAddToCart,
    );
  }
}
