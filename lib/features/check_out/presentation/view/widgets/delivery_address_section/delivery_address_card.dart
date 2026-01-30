import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/change_lang/presentation/view/widgets/localization_sheet_card.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({
    super.key,
    required this.address,
  });
  final AddressEntity address;

  @override
  Widget build(BuildContext context) {
   final bool isSelected=context.select(
      (CheckOutCubit cubit) => cubit.state.selectedAddress?.id == address.id,
    );
    return InkWell(
      enableFeedback: true,
      onTap: () {
        context.read<CheckOutCubit>().doIntent(
          SelectAddressEvent(address: address),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.whiteF9,
          boxShadow: [
            BoxShadow(color: AppColors.gray53.withOpacity(0.25), blurRadius: 4),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      selectionIndicator(isSelected),
                      Text(
                        address.city ?? "Location",
                        style: 16.medium.copyWith(color: AppColors.black0C),
                      ),
                    ],
                  ),
                  Text(
                    "${address.lat}+${address.long} - ${address.city}",
                    style: 13.regular.copyWith(color: AppColors.gray53),
                  ),
                ],
              ),
              const Icon(
                Icons.edit_outlined,
                size: 24,
                color: AppColors.gray53,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
