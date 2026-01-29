import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_button.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view/widgets/deletable_adress_cell.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view/widgets/loading_shimmer.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_events.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAddressesBody extends StatelessWidget {
  const UserAddressesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserAddressesCubit>();
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: BlocBuilder<UserAddressesCubit, UserAddressesStates>(
                builder: (context, state) {
                  final addressState = state.getUserAddressesState;
                  return addressState.when(
                    initial: () {
                      return const LoadingShimmer();
                    },
                    loading: () {
                      return const LoadingShimmer();
                    },
                    success: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return DeletableAddressCell(
                            key: ValueKey(data[index].id),
                            address: data[index],
                            onEdit: () {
                              // TODO GO TO EDIT ADDRESS SCREEN
                            },
                            onDeleteConfirmed: () {
                              if (data[index].id == null) return;
                              cubit.doIntent(
                                UserAddressesEvent.deleteAddress(
                                  data[index].id!,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    error: (message) {
                      return Center(child: Text(handleError(message) ?? ""));
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              onPressed: () {
                // TODO GO TO ADD NEW ADDRESS SCREEN
              },
              title: LocaleKeys.address_add_new_address.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
