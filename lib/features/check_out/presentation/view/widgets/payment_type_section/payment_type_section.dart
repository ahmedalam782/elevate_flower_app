import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/languages/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../domain/repositories/payment_repository.dart';
import 'payment_type_card.dart';
import 'package:flutter/material.dart';

class PaymentTypeSection extends StatefulWidget {
  const PaymentTypeSection({super.key});

  @override
  State<PaymentTypeSection> createState() => _PaymentTypeSectionState();
}

class _PaymentTypeSectionState extends State<PaymentTypeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            LocaleKeys.checkout_payment_method.tr(),
            style: 18.medium.copyWith(color: AppColors.black0C),
          ),
          const PaymentTypeCard(paymentStrategy: PaymentStrategy.cash),
          const PaymentTypeCard(paymentStrategy: PaymentStrategy.credit),
        ],
      ),
    );
  }
}
