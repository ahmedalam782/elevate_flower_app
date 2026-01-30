import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/payment_type_section/payment_type_card.dart';
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
            'Payment method',
            style: 18.medium.copyWith(color: AppColors.black0C),
          ),
          const PaymentTypeCard(paymentStrategy: PaymentStrategy.cash),
          const PaymentTypeCard(paymentStrategy: PaymentStrategy.credit),
        ],
      ),
    );
  }
}
