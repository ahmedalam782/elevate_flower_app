import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_events.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PriceSection extends StatefulWidget {
  const PriceSection({super.key, required this.totalPrice});
  final double totalPrice;
  @override
  State<PriceSection> createState() => _PriceSectionState();
}

class _PriceSectionState extends State<PriceSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_sub_total.tr(),
                style: 16.regular.copyWith(color: AppColors.gray53),
              ),
              Text(
                '${widget.totalPrice} \$',
                style: 16.regular.copyWith(color: AppColors.gray53),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.checkout_delivery_fee.tr(),
                style: 16.regular.copyWith(color: AppColors.gray53),
              ),
              Text(
                '10.00 \$',
                style: 16.regular.copyWith(color: AppColors.gray53),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.gray53),
          Row(
            children: [
              Text(
                LocaleKeys.checkout_total.tr(),
                style: 18.medium.copyWith(color: AppColors.black0C),
              ),
              const Spacer(),
              Text(
                '${widget.totalPrice + 10} \$',
                style: 18.medium.copyWith(color: AppColors.black0C),
              ),
            ],
          ),
          const SizedBox(height: 44),
          BlocConsumer<CheckOutCubit, CheckOutState>(
            listenWhen: (previous, current) =>
                previous.paymentResult != current.paymentResult,
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (BuildContext context, CheckOutState state) {
              return SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: LocaleKeys.checkout_place_order.tr(),
                  isLoading: state.isLoading!,
                  onPressed: () {
                    context.read<CheckOutCubit>().doIntent(CheckOutEvent());
                  },
                ),
              );
            },
            listener: (BuildContext context, CheckOutState state) async {
              if (state.paymentResult is PaymentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(LocaleKeys.checkout_payment_successful.tr()),
                  ),
                );
                context.pop();
              } else if (state.paymentResult is PaymentRedirect) {
                final paymentUrl =
                    (state.paymentResult as PaymentRedirect).paymentUrl;
                final result = await context.push(
                  Routes.webPay,
                  extra: paymentUrl,
                );
                if (mounted) {
                  handlePaymentCompletion(result, context);
                }
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void handlePaymentCompletion(Object? result, BuildContext context) {
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.checkout_payment_successful.tr())),
      );
      context.pop();
    } else if (result == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.checkout_payment_failed.tr())),
      );
    }
  }
}
