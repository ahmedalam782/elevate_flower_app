import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_tab_bar.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../../../../core/shared/widgets/error_page.dart';
import '../../../../../core/shared/widgets/paginated_product_grid_view.dart';
import '../../../../cart/presentation/view/widgets/custom_add_to_cart_button.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';
import '../../../../cart/presentation/view_model/cubit/cart_events.dart';
import '../../../../cart/presentation/view_model/cubit/cart_states.dart';
import '../../view_model/cubit/occasions_cubit.dart';
import '../../view_model/cubit/occasions_events.dart';
import '../../view_model/cubit/occasions_states.dart';

class OccasionsBody extends StatefulWidget {
  const OccasionsBody({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<OccasionsBody> createState() => _OccasionsBodyState();
}

class _OccasionsBodyState extends State<OccasionsBody> {
  late OccasionsCubit _cubit;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _cubit = context.read<OccasionsCubit>();
    _selectedTabIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionsCubit, OccasionsStates>(
      listener: (BuildContext context, OccasionsStates state) {
        if (state.occasions.state == StateType.error) {
          final error = state.occasions.exception;
          if (error is Failures) {
            CustomToast(
              context: context,
              header: error.errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        } if (state.productsByOccasion.state == StateType.error) {
          final error = state.productsByOccasion.exception;
          if (error is Failures) {
            CustomToast(
              context: context,
              header: error.errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        }
      },
      builder: (context, state) {
        if (state.occasions.state == StateType.error) {
          return ErrorPage(
            isConnectionerror: true,
            onRefresh: () async => _cubit.doIntent(
              OccasionsEvents.getOccasions(widget.selectedIndex ?? 0),
            ),
          );
        }
        return Column(
          children: [
            CustomTabBar(
              isInitialLoading: state.occasions.state == StateType.loading,
              itemsPerPage: state.occasions.data?.length ?? 0,
              tabList:
                  state.occasions.data
                      ?.map((occasion) => occasion.name)
                      .toList() ??
                  [],
              onSelectedItem: (int index) async {
                if (index == _selectedTabIndex) return;
                setState(() {
                  _selectedTabIndex = index;
                });
                final selectedOccasionId =
                    state.occasions.data?[index].id ?? '';
                _cubit.doIntent(
                  OccasionsEvents.changeSelectedOccasion(selectedOccasionId),
                );
              },
              selectedIndex: _selectedTabIndex,
            ),

            Expanded(
              child: BlocBuilder<CartCubit, CartStates>(
                builder: (context, cartState) {
                  return PaginatedProductGridView(
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
                    key: ValueKey(_selectedTabIndex),
                    isLoading:
                        state.productsByOccasion.state == StateType.loading ||
                        state.occasions.state == StateType.loading,
                    products: state.productsByOccasion.data ?? [],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
