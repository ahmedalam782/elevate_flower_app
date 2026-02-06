import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/languages/locale_keys.g.dart';
import '../../../../../../core/shared/widgets/custom_text_field.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../domain/repositories/payment_repository.dart';
import '../../../view_model/pay_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftSection extends StatefulWidget {
  const GiftSection({super.key});

  @override
  State<GiftSection> createState() => _GiftSectionState();
}

class _GiftSectionState extends State<GiftSection> {
  late bool isCredit;
  late bool isEnabled;
  bool changedOnce = false;
  @override
  Widget build(BuildContext context) {
    isCredit =
        context.select(
          (CheckOutCubit cubit) => cubit.state.selectedPaymentStrategy,
        ) ==
        PaymentStrategy.credit;
        
    // This to make the gift button enabled when credit is selected for the first time then be able to be changed
    if (isCredit) {
      if (!changedOnce) {
        isEnabled = true;
        changedOnce = true;
      }
    } else {
      changedOnce = false;
    }

    return AbsorbPointer(
      absorbing: !isCredit,
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
                  value: isCredit ? isEnabled : false,
                  onChanged: (value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                ),
                Text(
                  LocaleKeys.checkout_gift_section.tr(),
                  style: 18.medium.copyWith(color: AppColors.black0C),
                ),
              ],
            ),
            CustomTextField(
              labelText: LocaleKeys.checkout_gift_name.tr(),
              hintText: LocaleKeys.checkout_gift_name_hint.tr(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            CustomTextField(
              labelText: LocaleKeys.checkout_gift_phone.tr(),
              hintText: LocaleKeys.checkout_gift_phone_hint.tr(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ],
        ),
      ),
    );
  }
}
