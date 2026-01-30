import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/payment_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/cash_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/data/repositories/cash_payment_repository_impl.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';

class MockPaymentDataSource extends Mock implements PaymentDataSourceContract {}

void main() {
  late CashPaymentRepositoryImpl repository;
  late MockPaymentDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPaymentDataSource();
    repository = CashPaymentRepositoryImpl(mockDataSource);
  });

  group('CashPaymentRepositoryImpl', () {
    group('perform', () {
      final mockAddress = ShippingAddressModel(
        street: '123 Main St',
        phone: '+1234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
      );

      test(
        'should return PaymentSuccess when dataSource returns success',
        () async {
          // Arrange
          const mockOrderNumber = 'ORD-12345';
          final mockResponse = CashPaymentResponse(
            message: 'Payment successful',
            order: Order(
              orderNumber: mockOrderNumber,
              user: 'user123',
              totalPrice: 500,
              paymentType: 'Cash',
              isPaid: false,
              isDelivered: false,
              state: 'pending',
            ),
          );

          when(
            () => mockDataSource.payWithCash(address: mockAddress),
          ).thenAnswer((_) async => Success(data: mockResponse));

          // Act
          final result = await repository.perform(address: mockAddress);

          // Assert
          expect(result, isA<Success<PaymentResult>>());
          expect(
            (result as Success<PaymentResult>).data,
            isA<PaymentSuccess>().having(
              (p) => p.orderNum,
              'orderNum',
              mockOrderNumber,
            ),
          );

          verify(
            () => mockDataSource.payWithCash(address: mockAddress),
          ).called(1);
        },
      );

      test('should extract order number from response correctly', () async {
        // Arrange
        const expectedOrderNumber = 'ORD-99999';
        final mockResponse = CashPaymentResponse(
          message: 'Payment successful',
          order: Order(
            orderNumber: expectedOrderNumber,
            user: 'testuser',
            totalPrice: 1000,
            paymentType: 'Cash',
          ),
        );

        when(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentSuccess = successResult.data as PaymentSuccess;
        expect(paymentSuccess.orderNum, expectedOrderNumber);
      });

      test('should return empty string when order is null', () async {
        // Arrange
        final mockResponse = CashPaymentResponse(
          message: 'Payment successful',
          order: null,
        );

        when(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentSuccess = successResult.data as PaymentSuccess;
        expect(paymentSuccess.orderNum, '');
      });

      test('should return empty string when orderNumber is null', () async {
        // Arrange
        final mockResponse = CashPaymentResponse(
          message: 'Payment successful',
          order: Order(orderNumber: null, user: 'testuser'),
        );

        when(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentSuccess = successResult.data as PaymentSuccess;
        expect(paymentSuccess.orderNum, '');
      });

      test('should return Error when dataSource returns error', () async {
        // Arrange
        final mockException = Exception('Payment failed');
        when(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).thenAnswer((_) async => Error(exception: mockException));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        expect(result, isA<Error<PaymentResult>>());
        expect((result as Error<PaymentResult>).exception, mockException);

        verify(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).called(1);
      });

      test('should pass correct address to dataSource', () async {
        // Arrange
        final mockResponse = CashPaymentResponse(
          message: 'Success',
          order: Order(orderNumber: 'ORD-123'),
        );

        when(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        await repository.perform(address: mockAddress);

        // Assert
        verify(
          () => mockDataSource.payWithCash(address: mockAddress),
        ).called(1);
      });
    });

    group('paymentMethodType', () {
      test('should return PaymentStrategy.cash', () {
        // Act
        final paymentType = repository.paymentMethodType;

        // Assert
        expect(paymentType, PaymentStrategy.cash);
      });
    });

    group('interface compliance', () {
      test('should implement PaymentRepository', () {
        // Assert
        expect(repository, isA<PaymentRepository>());
      });
    });
  });
}
