import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_product_grid_view.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Example of integrating the product grid with BLoC/Cubit
///
/// This shows how to connect the grid widgets to your actual state management
/// Replace YourProductsCubit and YourProductsState with your actual implementations

// Example State
class ProductsState {
  final List<ProductItemEntity> products;
  final bool isLoading;
  final bool hasMore;
  final String? error;
  final int currentPage;
  final int totalPages;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.error,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  ProductsState copyWith({
    List<ProductItemEntity>? products,
    bool? isLoading,
    bool? hasMore,
    String? error,
    int? currentPage,
    int? totalPages,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

// Example Cubit
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(const ProductsState());

  // For infinite scroll
  Future<void> loadMoreProducts() async {
    if (state.isLoading || !state.hasMore) return;

    emit(state.copyWith(isLoading: true));

    try {
      // TODO: Replace with your actual API call
      // final response = await yourApiService.getProducts(
      //   page: state.currentPage + 1,
      //   limit: 10,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API response
      final newProducts = List.generate(
        10,
        (index) => ProductItemEntity(
          id: 'product_${state.products.length + index}',
          name: 'Red Roses',
          price: 800.0,
          priceAfterDiscount: 600.0,
          imageUrl: 'https://example.com/image.jpg',
        ),
      );

      emit(
        state.copyWith(
          products: [...state.products, ...newProducts],
          isLoading: false,
          hasMore: newProducts.isNotEmpty && state.products.length < 50,
          currentPage: state.currentPage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // For paginated view
  Future<void> loadPage(int page) async {
    emit(state.copyWith(isLoading: true, currentPage: page));

    try {
      // TODO: Replace with your actual API call
      // final response = await yourApiService.getProducts(
      //   page: page,
      //   limit: 10,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API response
      final pageProducts = List.generate(
        10,
        (index) => ProductItemEntity(
          id: 'product_${(page - 1) * 10 + index}',
          name: 'Red Roses',
          price: 800.0,
          priceAfterDiscount: 600.0,
          imageUrl: 'https://example.com/image.jpg',
        ),
      );

      emit(
        state.copyWith(
          products: pageProducts,
          isLoading: false,
          totalPages: 10, // Get this from API response
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Initial load
  Future<void> loadInitialProducts() async {
    emit(const ProductsState(isLoading: true));
    await loadMoreProducts(); // or loadPage(1) for paginated
  }

  // Refresh
  Future<void> refreshProducts() async {
    emit(const ProductsState(isLoading: true));
    await loadMoreProducts(); // or loadPage(1) for paginated
  }
}

/// Example page using the infinite scroll grid with BLoC
class ProductsInfiniteScrollPage extends StatelessWidget {
  const ProductsInfiniteScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..loadInitialProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.whiteFF,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            // Show error if any
            if (state.error != null && state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.sp,
                      color: AppColors.redCC,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Error loading products',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      state.error!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.gray7D,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductsCubit>().refreshProducts();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ProductsCubit>().refreshProducts();
              },
              color: AppColors.primerColor,
              child: CustomProductGridView(
                products: state.products,
                isLoading: state.isLoading,
                hasMore: state.hasMore,
                onLoadMore: () {
                  context.read<ProductsCubit>().loadMoreProducts();
                },
                onProductTap: (product) {
                  // TODO: Navigate to product details
                  // context.push('/product/${product.id}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped ${product.name}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                onAddToCart: (product) {
                  // TODO: Add to cart
                  // context.read<CartCubit>().addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart'),
                      backgroundColor: AppColors.green0C,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Example of using with your existing API service
/// 
/// 1. Create a method in your API service:
/// ```dart
/// class ProductsApiService {
///   @GET('/products')
///   Future<ProductsResponse> getProducts(
///     @Query('page') int page,
///     @Query('limit') int limit,
///   );
/// }
/// ```
/// 
/// 2. Create a response model:
/// ```dart
/// class ProductsResponse {
///   final List<ProductItemEntity> products;
///   final int totalPages;
///   final int currentPage;
///   final bool hasMore;
/// 
///   ProductsResponse({
///     required this.products,
///     required this.totalPages,
///     required this.currentPage,
///     required this.hasMore,
///   });
/// }
/// ```
/// 
/// 3. Use in your Cubit:
/// ```dart
/// Future<void> loadMoreProducts() async {
///   if (state.isLoading || !state.hasMore) return;
///   
///   emit(state.copyWith(isLoading: true));
///   
///   try {
///     final response = await _apiService.getProducts(
///       page: state.currentPage + 1,
///       limit: 10,
///     );
///     
///     emit(state.copyWith(
///       products: [...state.products, ...response.products],
///       isLoading: false,
///       hasMore: response.hasMore,
///       currentPage: response.currentPage,
///       totalPages: response.totalPages,
///     ));
///   } catch (e) {
///     emit(state.copyWith(
///       isLoading: false,
///       error: e.toString(),
///     ));
///   }
/// }
/// ```
