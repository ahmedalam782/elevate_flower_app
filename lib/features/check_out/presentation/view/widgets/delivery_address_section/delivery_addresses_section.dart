import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view/widgets/delivery_address_section/delivery_address_card.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_events.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressesSection extends StatefulWidget {
  const DeliveryAddressesSection({super.key});

  @override
  State<DeliveryAddressesSection> createState() =>
      _DeliveryAddressesSectionState();
}

class _DeliveryAddressesSectionState extends State<DeliveryAddressesSection> {
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
            'Delivery Address',
            style: 18.medium.copyWith(color: AppColors.black0C),
          ),
          BlocSelector<
            CheckOutCubit,
            CheckOutState,
            BaseState<List<AddressEntity>>?
          >(
            selector: (state) => state.userAddressesState,
            builder: (context, userAddressesState) {
              if (userAddressesState == null) {
                context.read<CheckOutCubit>().doIntent(GetUserAddressesEvent());
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (userAddressesState.state == StateType.loading) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (userAddressesState.state == StateType.success) {
                final addresses = userAddressesState.data!;
                return Column(
                  spacing: 16,
                  children: addresses.map((address) {
                    return DeliveryAddressCard(
                      address: address,
                    );
                  }).toList(),
                );
              } else {
                return Text(
                  "Could not load addresses",
                  style: 16.medium.copyWith(color: AppColors.gray53),
                );
              }
            },
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.grayA6),
            ),
            child: Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 24, color: AppColors.primerColor),
                Text(
                  "Add New",
                  style: 14.medium.copyWith(color: AppColors.primerColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
