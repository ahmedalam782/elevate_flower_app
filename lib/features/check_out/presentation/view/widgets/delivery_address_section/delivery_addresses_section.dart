import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/config/base_state/base_state.dart';
import '../../../../../../core/config/di/injectable_config.dart';
import '../../../../../../core/languages/locale_keys.g.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../domain/entities/address_entity.dart';
import 'delivery_address_card.dart';
import '../../../view_model/pay_cubit/check_out_cubit.dart';
import '../../../view_model/pay_cubit/check_out_events.dart';
import '../../../view_model/pay_cubit/check_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeliveryAddressesSection extends StatelessWidget {
  const DeliveryAddressesSection({super.key});
  
  @override
  void didUpdateWidget(covariant DeliveryAddressesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    CheckOutCubit checkoutCubit = getIt<CheckOutCubit>()
      ..doIntent(GetUserAddressesEvent());
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            LocaleKeys.checkout_delivery_address.tr(),
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
                return const SizedBox(
                  height: 100,
                  child: Center(child: Text("No addresses available")),
                );
              } else if (userAddressesState.state == StateType.loading) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (userAddressesState.state == StateType.success) {
                final addresses = userAddressesState.data!;
                return Column(
                  spacing: 16,
                  children: addresses.map((address) {
                    return DeliveryAddressCard(
                      address: address,
                      onEdit: () async {
                        final updated =
                            await context.push(
                                  Routes.addressDetails,
                                  extra: address.toAddressDetailsData(),
                                )
                                as bool;
                        if (updated && context.mounted) {
                          context.read<CheckOutCubit>().doIntent(
                            GetUserAddressesEvent(),
                          );
                        }
                      },
                    );
                  }).toList(),
                );
              } else {
                return Text(
                  LocaleKeys.checkout_checkout_addresses_loading_error.tr(),
                  style: 16.medium.copyWith(color: AppColors.gray53),
                );
              }
            },
          ),
          OutlinedButton(
            onPressed: () async {
              final added = await context.push(Routes.addressDetails) as bool;
              if (added && context.mounted) {
                checkoutCubit.doIntent(GetUserAddressesEvent());
              }
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.grayA6),
            ),
            child: Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, size: 24, color: AppColors.primerColor),
                Text(
                  LocaleKeys.checkout_add_new_address.tr(),
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
