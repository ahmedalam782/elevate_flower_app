import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_item.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_upper_part.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPageWithData extends StatelessWidget {
  const CartPageWithData({super.key, required this.cartViewModel});

  final CartCubit cartViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartUpperPart(),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                cartViewModel.doIntent(ClearUserCartEvent());
              },
              child: Text(
                LocaleKeys.cart_clear.tr(),
                style: 18.medium.copyWith(color: AppColors.primerColor),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: BlocSelector<CartCubit, CartStates, bool>(
            selector: (state) {
              return state.isAddingItem ||
                  state.isDecrementingItem ||
                  state.isRemovingItem;
            },
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final currentProduct =
                      cartViewModel.state.state.data?.cartProducts[index];
                  return CartItemWidget(
                    onAddFunction: () {
                      // if(vm.)
                      if (cartViewModel.state.currentActedUponProductId == "") {
                        cartViewModel.doIntent(
                          AddProductToCartEvent(
                            fromCartScreen: true,
                            index: index,
                            productId:
                                cartViewModel
                                    .state
                                    .state
                                    .data
                                    ?.cartProducts[index]
                                    .id ??
                                "",
                          ),
                        );
                      }
                    },
                    onRemoveFunction: () {
                      // if(vm.)
                      if (cartViewModel.state.currentActedUponProductId == "") {
                        cartViewModel.doIntent(
                          RemoveProductFromCartEvent(
                            productId: currentProduct?.id ?? "",
                          ),
                        );
                      }
                    },
                    isAdding:
                        cartViewModel.state.isAddingItem &&
                        cartViewModel.state.currentActedUponProductId ==
                            currentProduct?.id,
                    isDecremnting:
                        cartViewModel.state.isDecrementingItem &&
                        cartViewModel.state.currentActedUponProductId ==
                            currentProduct?.id,
                    isDeleting:
                        cartViewModel.state.isRemovingItem &&
                        cartViewModel.state.currentActedUponProductId ==
                            currentProduct?.id,
                    cartProduct:
                        cartViewModel.state.state.data!.cartProducts[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.h);
                },
                itemCount:
                    cartViewModel.state.state.data?.cartProducts.length ?? 0,
              );
            },
          ),
        ),
        SizedBox(height: 32.h),
        Divider(color: AppColors.grayA6, thickness: 0.5),
        BlocSelector<CartCubit, CartStates, double?>(
          selector: (state) {
            return state.totalPrice;
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.cart_total.tr(), style: 18.medium),
                Text(
                  "$state ${LocaleKeys.products_EGP.tr()}",
                  style: 18.medium,
                ),
              ],
            );
          },
        ),
        SizedBox(height: 32.h),
        CustomButton(
          radius: 20.r,
          title: LocaleKeys.cart_check_out.tr(),
          borderColor: Colors.transparent,
          onPressed: () {},
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
