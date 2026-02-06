import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/config/di/injectable_config.dart';

import '../../../domain/entities/cart_entity.dart';
import '../widgets/cart_empty_widget.dart';
import '../widgets/cart_page_with_data.dart';
import '../widgets/not_autenticated_user_widget.dart';
import '../../view_model/cubit/cart_cubit.dart';
import '../../view_model/cubit/cart_events.dart';
import '../../view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin{
  late CartCubit vm;
  @override
  void initState() {
    vm = getIt<CartCubit>()..doIntent(GetCartDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<CartCubit>.value(
      value: vm,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocSelector<CartCubit, CartStates, BaseState<CartEntity>>(
            selector: (state) {
              return state.state;
            },
            builder: (context, state) {
              if (state.state == StateType.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.state == StateType.error) {
                return const NotAutenticatedUserWidget();
              }
              if (state.state == StateType.success) {
                if (state.data?.cartProducts.isEmpty ?? true) {
                  return const CartEmptyWidget();
                } else {
                  return CartPageWithData(cartViewModel: vm);
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
