import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/change_lang/presentation/view/widgets/localization_sheet_card.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentTypeCard extends StatelessWidget {
  const PaymentTypeCard({
    super.key,
    required this.paymentStrategy,
  });
  final PaymentStrategy paymentStrategy;
  @override
  Widget build(BuildContext context) {
    final isSelected =
        paymentStrategy ==
        context.select(
          (CheckOutCubit cubit) => cubit.state.selectedPaymentStrategy,
        );

    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.read<CheckOutCubit>().doIntent(
            SelectPaymentMethodEvent(paymentMethodType: paymentStrategy),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.5, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              paymentStrategy == PaymentStrategy.cash ? LocaleKeys.checkout_cash.tr() : LocaleKeys.checkout_credit_card.tr(),
              style: 16.medium.copyWith(color: AppColors.black0C),
            ),
            selectionIndicator(isSelected),
          ],
        ),
      ),
    );
  }
}
