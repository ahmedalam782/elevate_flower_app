import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_shimmer_container.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_shimmer_grid.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_item.dart';
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_upper_part.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit vm;
  @override
  void initState() {
    vm = getIt<CartCubit>()..doIntent(GetCartData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => vm,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocSelector<CartCubit, CartStates, BaseState<CartEntity>>(
            selector: (state) {
              return state.state;
            },
            builder: (context, state) {
              print("BUILD");
              if (state.state == StateType.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.state == StateType.error) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.state == StateType.success) {
                return Column(
                  children: [
                    CartUpperPart(),
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
                              return CartItem(
                                onAddFunction: () {
                                  // if(vm.)
                                  if (vm.state.currentActedUponItemIndex !=
                                      -1) {
                                    vm.doIntent(AddProductToCart(index: index));
                                  }
                                },
                                isAdding:
                                    vm.state.isAddingItem &&
                                    vm.state.currentActedUponItemIndex == index,
                                isDecremnting:
                                    vm.state.isDecrementingItem &&
                                    vm.state.currentActedUponItemIndex == index,
                                isDeleting:
                                    vm.state.isRemovingItem &&
                                    vm.state.currentActedUponItemIndex == index,
                                cartProduct:
                                    vm.state.state.data!.cartProducts[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24.h);
                            },
                            itemCount:
                                vm.state.state.data?.cartProducts.length ?? 0,
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
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
