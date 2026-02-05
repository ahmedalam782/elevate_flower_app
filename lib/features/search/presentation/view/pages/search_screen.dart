import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_product_grid_view.dart';
import '../../../../../core/shared/widgets/search_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import '../../view_model/cubit/search_cubit.dart';
import '../../view_model/cubit/search_events.dart';
import '../../view_model/cubit/search_states.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';
import '../../../../cart/presentation/view_model/cubit/cart_events.dart';
import '../../../../cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: BlocProvider.value(
        value: getIt<CartCubit>(),
        child: const _SearchScreenContent(),
      ),
    );
  }
}

class _SearchScreenContent extends StatelessWidget {
  const _SearchScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteFF,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SearchWidget(
                showDateFilter: false,
                showBackButton: true,
                title: LocaleKeys.custom_widgets_search.tr(),
                onSearchChanged: (query) {
                  context.read<SearchCubit>().doIntent(
                    SearchEvents.search(keyword: query ?? ''),
                  );
                },
              ),
            ),
            // Content
            Expanded(
              child: BlocBuilder<SearchCubit, SearchStates>(
                builder: (context, state) {
                  return state.searchState.when(
                    initial: () => Center(
                      child: Text(
                        LocaleKeys.products_search_for_product.tr(),
                        style: 16.medium.copyWith(color: AppColors.primerColor),
                      ),
                    ),
                    loading: () => const CustomProductGridView(
                      products: [],
                      isLoading: true,
                    ),
                    success: (products) {
                      if (products.isEmpty) {
                        return Center(
                          child: Text(
                            LocaleKeys.products_no_products.tr(),
                            style: 16.medium.copyWith(color: AppColors.redCC),
                          ),
                        );
                      }
                      return BlocBuilder<CartCubit, CartStates>(
                        builder: (context, cartState) {
                          return CustomProductGridView(
                            products: state.products,
                            isLoading:
                                state.searchState.state ==
                                StateType.moreLoading,
                            hasMore: !state.isLastPage,
                            onLoadMore: () {
                              context.read<SearchCubit>().doIntent(
                                SearchEvents.loadMore(),
                              );
                            },
                            onProductTap: (product) {
                              context.push(
                                Routes.productDetails,
                                extra: product.id,
                              );
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
                                    RemoveProductFromCartEvent(
                                      productId: product.id,
                                    ),
                                  );
                                }
                              }
                            },
                            onRemove: (product) {
                              context.read<CartCubit>().doIntent(
                                RemoveProductFromCartEvent(
                                  productId: product.id,
                                ),
                              );
                            },
                            getQuantity: (productId) {
                              final cartProducts =
                                  cartState.state.data?.cartProducts ?? [];
                              final itemIndex = cartProducts.indexWhere(
                                (e) => e.id == productId,
                              );
                              return itemIndex != -1
                                  ? cartProducts[itemIndex]
                                        .productQuantityInCart
                                  : 0;
                            },
                          );
                        },
                      );
                    },
                    error: (exception) => Center(
                      child: Text(
                        exception.toString(),
                        style: 16.medium.copyWith(color: AppColors.redCC),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
