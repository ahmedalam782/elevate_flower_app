import 'package:elevate_flower_app/core/shared/widgets/custom_text_field.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftSection extends StatefulWidget {
  const GiftSection({super.key});

  @override
  State<GiftSection> createState() => _GiftSectionState();
}

class _GiftSectionState extends State<GiftSection> {
  bool isGift = false;
  @override
  Widget build(BuildContext context) {
    isGift =
        context.select(
          (CheckOutCubit cubit) => cubit.state.selectedPaymentStrategy,
        ) ==
        PaymentStrategy.credit;
    return AbsorbPointer(
      absorbing: !isGift,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.whiteF9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Switch(
                  inactiveThumbColor: AppColors.primerColor,
                  inactiveTrackColor: AppColors.whiteF9,
                  value: isGift,
                  onChanged: (value) {
                    setState(() {
                      isGift = value;
                    });
                  },
                ),
                Text(
                  'It\'s a gift',
                  style: 18.medium.copyWith(color: AppColors.black0C),
                ),
              ],
            ),
            const CustomTextField(
              labelText: 'Name',
              hintText: "Enter the name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            const CustomTextField(
              labelText: 'Phone Number',
              hintText: "Enter the phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ],
        ),
      ),
    );
  }
}
