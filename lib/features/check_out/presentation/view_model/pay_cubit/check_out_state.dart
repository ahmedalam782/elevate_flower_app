import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

class CheckOutState extends Equatable {
  final bool? isLoading;
  final Exception? error;
  final PaymentResult? paymentResult;
  final BaseState<List<AddressEntity>>? userAddressesState;
  final AddressEntity? selectedAddress;
  final PaymentStrategy? selectedPaymentStrategy;

  const CheckOutState({
    this.isLoading = false,
    this.error,
    this.paymentResult,
    this.userAddressesState,
    this.selectedPaymentStrategy,
    this.selectedAddress,
  });

  CheckOutState copyWith({
    bool? isLoading,
    Exception? error,
    PaymentResult? paymentResult,
    BaseState<List<AddressEntity>>? userAddressesState,
    PaymentStrategy? selectedPaymentStrategy,
    AddressEntity? selectedAddress,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      paymentResult: paymentResult ?? this.paymentResult,
      userAddressesState: userAddressesState ?? this.userAddressesState,
      selectedPaymentStrategy:
          selectedPaymentStrategy ?? this.selectedPaymentStrategy,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    error,
    paymentResult,
    userAddressesState,
    selectedPaymentStrategy,
    selectedAddress,
  ];
}
