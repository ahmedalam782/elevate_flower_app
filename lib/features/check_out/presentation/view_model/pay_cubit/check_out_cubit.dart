import 'dart:developer';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/repositories/payment_repository.dart';
import '../../../domain/use_cases/get_user_addresses_use_case.dart';
import '../../../domain/use_cases/pay_use_case.dart';
import 'check_out_events.dart';
import 'check_out_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckOutCubit extends Cubit<CheckOutState> {
  final PayUseCase payUseCase;
  final GetUserAddressesUseCase getUserAddressesUseCase;
  CheckOutCubit({
    required this.payUseCase,
    required this.getUserAddressesUseCase,
  }) : super(
         const CheckOutState(selectedPaymentStrategy: PaymentStrategy.cash),
       );

  Future<void> doIntent(CheckOutEvents event) async {
    switch (event) {
      case CheckOutEvent():
        await _pay();
      case SelectPaymentMethodEvent():
        _selectPaymentStrategy(event.paymentMethodType);
      case GetUserAddressesEvent():
        await _getUserAddresses();
      case SelectAddressEvent():
        _setSelectedAddress(event.address);
    }
  }

  void _selectPaymentStrategy(PaymentStrategy strategy) {
    emit(
      state.copyWith(selectedPaymentStrategy: strategy, paymentResult: null),
    );
  }

  Future<void> _pay() async {
    if (state.selectedPaymentStrategy == null) {
      emit(state.copyWith(error: Exception('Payment strategy not selected')));
      return;
    }
    emit(state.copyWith(isLoading: true));
    final paymentRepository = state.selectedPaymentStrategy!
        .getPaymentRepository();
    final result = await payUseCase.call(
      paymentRepository: paymentRepository,
      address: state.selectedAddress!.toModel(),
    );
    result.when(
      success: (paymentResult) {
        emit(state.copyWith(isLoading: false, paymentResult: paymentResult));
      },
      error: (error) {
        emit(state.copyWith(isLoading: false, error: error));
      },
    );
  }

  void _setSelectedAddress(AddressEntity address) {
    emit(
      state.copyWith(
        selectedAddress: address,
        userAddressesState: BaseState.success(
          state.userAddressesState?.data ?? [],
        ),
      ),
    );
  }

  Future<void> _getUserAddresses() async {
    emit(state.copyWith(userAddressesState: const BaseState.loading()));
    final result = await getUserAddressesUseCase.call();
    result.when(
      success: (addresses) {
        emit(
          state.copyWith(
            userAddressesState: BaseState.success(addresses ?? []),
            selectedAddress: (addresses!.isEmpty) ? null : addresses.first,
          ),
        );
        log("${state.selectedAddress}");
      },
      error: (error) {
        emit(state.copyWith(userAddressesState: BaseState.error(error)));
      },
    );
  }
}

