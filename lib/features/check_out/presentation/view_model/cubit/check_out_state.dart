import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:equatable/equatable.dart';

class CheckOutState extends Equatable {
  final bool? isLoading;
  final Exception? error;
  final PaymentResult? paymentResult;

  const CheckOutState({this.isLoading = false, this.error, this.paymentResult});

  CheckOutState copyWith({
    bool? isLoading,
    Exception? error,
    PaymentResult? paymentResult,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      paymentResult: paymentResult ?? this.paymentResult,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, paymentResult];
}
