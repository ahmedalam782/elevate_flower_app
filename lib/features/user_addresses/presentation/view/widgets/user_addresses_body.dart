import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/errors/handle_errors/handle_errors.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import 'deletable_adress_cell.dart';
import 'loading_shimmer.dart';
import '../../view_model/cubit/user_addresses_cubit.dart';
import '../../view_model/cubit/user_addresses_events.dart';
import '../../view_model/cubit/user_addresses_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                            onEdit: () async {
                              final didAdd = await context.push(
                                Routes.addressDetails,
                                extra: data[index].toAddressDetailsData(),
                              );
                              if (didAdd == true) {
                                cubit.doIntent(const GetAllAddressesEvent());
                              }
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
              onPressed: () async {
                // TODO GO TO ADD NEW ADDRESS SCREEN
                final didAdd = await context.push(Routes.addressDetails);
                if (didAdd == true) {
                  cubit.doIntent(const GetAllAddressesEvent());
                }
              },
              title: LocaleKeys.address_add_new_address.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
