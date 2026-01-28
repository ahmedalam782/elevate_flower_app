import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:elevate_flower_app/features/check_out/domain/use_cases/pay_use_case.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/cubit/check_out_events.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/cubit/check_out_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class CheckOutCubit extends Cubit<CheckOutState> {
  final PayUseCase payUseCase;
  PaymentStrategy? selectedPaymentStrategy;
  CheckOutCubit(this.payUseCase) : super(const CheckOutState());

  void doIntent(CheckOutEvents event) {
    switch (event) {
      case CheckOutEvent():
        pay(address: event.address);
        break;
      case SelectPaymentMethodEvent():
        selectPaymentStrategy(event.paymentMethodType);
        break;
    }

  }

  void selectPaymentStrategy(PaymentStrategy strategy) {
    selectedPaymentStrategy = strategy;
    emit(state.copyWith());
  }

  Future<void> pay({required ShippingAddressModel address}) async {
    if (selectedPaymentStrategy == null) {
      throw Exception('Payment strategy not selected');
    }
    emit(state.copyWith(isLoading: true));
    final paymentRepository = selectedPaymentStrategy!.getPaymentRepository();
    final result = await payUseCase.call(
      paymentRepository: paymentRepository,
      address: address,
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
}
