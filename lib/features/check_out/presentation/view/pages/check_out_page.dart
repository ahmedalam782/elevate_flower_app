import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/mian/check_out_body.dart';
import '../widgets/mian/checkout_app_bar.dart';
import '../../view_model/pay_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayEA,
      appBar: CheckoutAppBar(
        title: LocaleKeys.checkout_checkout.tr(),
        context: context,
      ),
      body: BlocProvider.value(
        value: getIt<CheckOutCubit>(),
        child: CheckOutBody(totalPrice: totalPrice),
      ),
    );
  }
}
