import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/check_out/data/datasources/payment_data_source_contract.dart';
import 'package:elevate_flower_app/features/check_out/data/models/credit_payment_response.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/data/repositories/credit_payment_repository_impl.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';

class MockPaymentDataSource extends Mock implements PaymentDataSourceContract {}

void main() {
  late CreditPaymentRepositoryImpl repository;
  late MockPaymentDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPaymentDataSource();
    repository = CreditPaymentRepositoryImpl(mockDataSource);
  });

  group('CreditPaymentRepositoryImpl', () {
    group('perform', () {
      final mockAddress = ShippingAddressModel(
        street: '123 Main St',
        phone: '+1234567890',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
      );

      test(
        'should return PaymentRedirect when dataSource returns success',
        () async {
          // Arrange
          const mockPaymentUrl =
              'https://checkout.stripe.com/pay/cs_test_123456';
          final mockSession = Session(
            id: 'cs_test_123456',
            object: 'checkout.session',
            url: mockPaymentUrl,
          );
          final mockResponse = CreditPaymentResponse(
            message: 'Checkout session created',
            session: mockSession,
          );

          when(
            () => mockDataSource.payWithCredit(address: mockAddress),
          ).thenAnswer((_) async => Success(data: mockResponse));

          // Act
          final result = await repository.perform(address: mockAddress);

          // Assert
          expect(result, isA<Success<PaymentResult>>());
          expect(
            (result as Success<PaymentResult>).data,
            isA<PaymentRedirect>().having(
              (p) => p.paymentUrl,
              'paymentUrl',
              mockPaymentUrl,
            ),
          );

          verify(
            () => mockDataSource.payWithCredit(address: mockAddress),
          ).called(1);
        },
      );

      test('should extract payment URL from response correctly', () async {
        // Arrange
        const expectedUrl = 'https://checkout.stripe.com/pay/cs_live_abc123';
        final mockSession = Session(id: 'cs_live_abc123', url: expectedUrl);
        final mockResponse = CreditPaymentResponse(
          message: 'Success',
          session: mockSession,
        );

        when(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentRedirect = successResult.data as PaymentRedirect;
        expect(paymentRedirect.paymentUrl, expectedUrl);
      });

      test('should return empty string when session is null', () async {
        // Arrange
        final mockResponse = CreditPaymentResponse(
          message: 'Success',
          session: null,
        );

        when(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentRedirect = successResult.data as PaymentRedirect;
        expect(paymentRedirect.paymentUrl, '');
      });

      test('should return empty string when url is null', () async {
        // Arrange
        final mockSession = Session(id: 'cs_test_123', url: null);
        final mockResponse = CreditPaymentResponse(
          message: 'Success',
          session: mockSession,
        );

        when(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        final successResult = result as Success<PaymentResult>;
        final paymentRedirect = successResult.data as PaymentRedirect;
        expect(paymentRedirect.paymentUrl, '');
      });

      test('should return Error when dataSource returns error', () async {
        // Arrange
        final mockException = Exception('Credit payment failed');
        when(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).thenAnswer((_) async => Error(exception: mockException));

        // Act
        final result = await repository.perform(address: mockAddress);

        // Assert
        expect(result, isA<Error<PaymentResult>>());
        expect((result as Error<PaymentResult>).exception, mockException);

        verify(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).called(1);
      });

      test('should pass correct address to dataSource', () async {
        // Arrange
        final mockSession = Session(
          id: 'cs_test_123',
          url: 'https://checkout.stripe.com/pay/cs_test_123',
        );
        final mockResponse = CreditPaymentResponse(
          message: 'Success',
          session: mockSession,
        );

        when(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).thenAnswer((_) async => Success(data: mockResponse));

        // Act
        await repository.perform(address: mockAddress);

        // Assert
        verify(
          () => mockDataSource.payWithCredit(address: mockAddress),
        ).called(1);
      });
    });

    group('paymentMethodType', () {
      test('should return PaymentStrategy.credit', () {
        // Act
        final paymentType = repository.paymentMethodType;

        // Assert
        expect(paymentType, PaymentStrategy.credit);
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
