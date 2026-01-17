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
import 'package:elevate_flower_app/features/cart/presentation/view/widgets/cart_page_with_data.dart';
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
    vm = getIt<CartCubit>()..doIntent(GetCartDataEvent());
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
              if (state.state == StateType.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.state == StateType.error) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.state == StateType.success) {
                if (state.data?.cartProducts.isEmpty ?? true) {
                } else {
                  return CartPageWithData(cartViewModel: vm);
                }
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
