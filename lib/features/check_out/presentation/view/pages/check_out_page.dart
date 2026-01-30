import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/mian/check_out_body.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/mian/checkout_app_bar.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayEA,
      appBar: CheckoutAppBar(title: "Checkout", context: context),
      body: BlocProvider.value(
        value: getIt<CheckOutCubit>(),
        child: CheckOutBody(totalPrice: totalPrice),
      ),
    );
  }
}
