import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/api/end_points.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/action_widget.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../view_model/cubit/cart_cubit.dart';
import '../../view_model/cubit/cart_events.dart';
import '../../view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class CustomAddToCartButton extends StatelessWidget {
  final String productId;
  const CustomAddToCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          final cartProducts = state.state.data?.cartProducts ?? [];
          final itemIndex = cartProducts.indexWhere((e) => e.id == productId);
          final quantity = itemIndex != -1
              ? cartProducts[itemIndex].productQuantityInCart
              : 0;

          if (quantity > 0) {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primerColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Decrement Button
                  GestureDetector(
                    onTap: () async {
                      if (quantity == 1) {
                        getIt<CartCubit>().doIntent(
                          RemoveProductFromCartEvent(productId: productId),
                        );
                      } else {
                        getIt<CartCubit>().doIntent(
                          UpdateProductInCartEvent(
                            productId: productId,
                            qunatity: quantity - 1,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),

                  // Quantity
                  Text(
                    '$quantity',
                    style: 18.semiBold.copyWith(color: Colors.white),
                  ),

                  // Increment Button
                  GestureDetector(
                    onTap: () async {
                      await addToCart(context, productId);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return CustomButton(
            isLoading:
                state.isAddingItem &&
                state.currentActedUponProductId == productId,
            onPressed: () async {
              await addToCart(context, productId);
            },
            title: LocaleKeys.product_details_add_to_cart.tr(),
          );
        },
      ),
    );
  }
}

Future<void> addToCart(BuildContext context, String productId) async {
  final token = await getIt<FlutterSecureStorage>().read(
    key: Apikeys.accessToken,
  );
  if (!context.mounted) return;
  if (token != null && token.isNotEmpty) {
    getIt<CartCubit>()
        .doIntent(
          AddProductToCartEvent(productId: productId, fromCartScreen: false),
        )
        .then((value) {
          if (!context.mounted) return;
          if (value == true) {
            CustomToast(
              context: context,
              header: LocaleKeys.global_success.tr(),
              description: LocaleKeys.cart_item_added_to_cart.tr(),
              type: ToastificationType.success,
            ).showToast();
          } else {
            CustomToast(
              context: context,
              header: LocaleKeys.global_error.tr(),
              description: (value as Failures).errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        });
  } else {
    showActionDialog(
      context: context,
      description: "",
      title: LocaleKeys.cart_to_continue_Shopping.tr(),
      onAction: () {
        if (context.mounted) {
          context.go(Routes.login);
        }
      },
    );
  }
}
