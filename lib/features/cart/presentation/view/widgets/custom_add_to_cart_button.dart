import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/action_widget.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class CustomAddToCartButton extends StatelessWidget {
  final String productId;
  const CustomAddToCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // create: (context) => SubjectBloc(),
      value: getIt<CartCubit>(),
      child: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          return CustomButton(
            // isLoading: state,
            isLoading: false,
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
