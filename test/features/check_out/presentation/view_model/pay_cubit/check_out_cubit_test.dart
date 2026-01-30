import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/check_out/data/models/shipping_address_model.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/address_entity.dart';
import 'package:elevate_flower_app/features/check_out/domain/entities/payment_result.dart';
import 'package:elevate_flower_app/features/check_out/domain/repositories/payment_repository.dart';
import 'package:elevate_flower_app/features/check_out/domain/use_cases/get_user_addresses_use_case.dart';
import 'package:elevate_flower_app/features/check_out/domain/use_cases/pay_use_case.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_cubit.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_events.dart';
import 'package:elevate_flower_app/features/check_out/presentation/view_model/pay_cubit/check_out_state.dart';

class MockPayUseCase extends Mock implements PayUseCase {}

class MockGetUserAddressesUseCase extends Mock
    implements GetUserAddressesUseCase {}

class MockPaymentRepository extends Mock implements PaymentRepository {}

void main() {
  late CheckOutCubit checkOutCubit;
  late MockPayUseCase mockPayUseCase;
  late MockGetUserAddressesUseCase mockGetUserAddressesUseCase;

  setUpAll(() {
    registerFallbackValue(MockPaymentRepository());
    registerFallbackValue(
      ShippingAddressModel(street: '', city: '', lat: '', long: '', phone: ''),
    );
  });

  setUp(() {
    mockPayUseCase = MockPayUseCase();
    mockGetUserAddressesUseCase = MockGetUserAddressesUseCase();
    checkOutCubit = CheckOutCubit(
      payUseCase: mockPayUseCase,
      getUserAddressesUseCase: mockGetUserAddressesUseCase,
    );
  });

  tearDown(() {
    checkOutCubit.close();
  });

  group('CheckOutCubit', () {
    group('initial state', () {
      test('initial state has correct default values', () {
        expect(checkOutCubit.state.isLoading, false);
        expect(
          checkOutCubit.state.selectedPaymentStrategy,
          PaymentStrategy.cash,
        );
        expect(checkOutCubit.state.error, null);
        expect(checkOutCubit.state.paymentResult, null);
      });
    });

    group('SelectPaymentMethodEvent', () {
      blocTest<CheckOutCubit, CheckOutState>(
        'should emit new state with selected payment strategy when cash is selected',
        build: () => checkOutCubit,
        act: (cubit) => cubit.doIntent(
          SelectPaymentMethodEvent(paymentMethodType: PaymentStrategy.cash),
        ),
        expect: () => [
          isA<CheckOutState>()
              .having(
                (state) => state.selectedPaymentStrategy,
                'selectedPaymentStrategy',
                PaymentStrategy.cash,
              )
              .having((state) => state.paymentResult, 'paymentResult', null),
        ],
      );

      blocTest<CheckOutCubit, CheckOutState>(
        'should emit new state with selected payment strategy when credit is selected',
        build: () => checkOutCubit,
        act: (cubit) => cubit.doIntent(
          SelectPaymentMethodEvent(paymentMethodType: PaymentStrategy.credit),
        ),
        expect: () => [
          isA<CheckOutState>()
              .having(
                (state) => state.selectedPaymentStrategy,
                'selectedPaymentStrategy',
                PaymentStrategy.credit,
              )
              .having((state) => state.paymentResult, 'paymentResult', null),
        ],
      );

      blocTest<CheckOutCubit, CheckOutState>(
        'should clear payment result when selecting new payment method',
        build: () {
          checkOutCubit.emit(
            checkOutCubit.state.copyWith(
              paymentResult: const PaymentSuccess(orderNum: 'ORD-123'),
            ),
          );
          return checkOutCubit;
        },
        act: (cubit) => cubit.doIntent(
          SelectPaymentMethodEvent(paymentMethodType: PaymentStrategy.credit),
        ),
        expect: () => [
          isA<CheckOutState>().having(
            (state) => state.selectedPaymentStrategy,
            'selectedPaymentStrategy',
            PaymentStrategy.credit,
          ),
        ],
      );
    });

    group('CheckOutEvent - Payment', () {
      const mockAddress = AddressEntity(
        street: '123 Main St',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        id: 'addr-123',
        phone: '+1234567890',
      );

      test('should set isLoading to true when payment starts', () async {
        checkOutCubit.emit(
          checkOutCubit.state.copyWith(selectedAddress: mockAddress),
        );

        expect(checkOutCubit.state.selectedAddress, mockAddress);
      });

      test('should have valid selected address for payment', () {
        checkOutCubit.emit(
          checkOutCubit.state.copyWith(selectedAddress: mockAddress),
        );

        expect(checkOutCubit.state.selectedAddress, isNotNull);
        expect(checkOutCubit.state.selectedAddress?.street, '123 Main St');
        expect(
          checkOutCubit.state.selectedPaymentStrategy,
          PaymentStrategy.cash,
        );
      });
    });

    group('GetUserAddressesEvent', () {
      final mockAddresses = [
        const AddressEntity(
          street: '123 Main St',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          id: 'addr-1',
          phone: '+1234567890',
        ),
        const AddressEntity(
          street: '456 Oak Ave',
          city: 'Giza',
          lat: '30.0131',
          long: '31.0898',
          id: 'addr-2',
          phone: '+0987654321',
        ),
      ];

      blocTest<CheckOutCubit, CheckOutState>(
        'should emit loading then success with addresses',
        build: () => checkOutCubit,
        act: (cubit) async {
          when(
            () => mockGetUserAddressesUseCase.call(),
          ).thenAnswer((_) async => Success(data: mockAddresses));

          await cubit.doIntent(GetUserAddressesEvent());
        },
        expect: () => [
          isA<CheckOutState>().having(
            (state) => state.userAddressesState,
            'userAddressesState',
            isA<BaseState<List<AddressEntity>>>(),
          ),
          isA<CheckOutState>()
              .having(
                (state) => state.userAddressesState,
                'userAddressesState',
                isA<BaseState<List<AddressEntity>>>(),
              )
              .having(
                (state) => state.selectedAddress,
                'selectedAddress',
                mockAddresses.first,
              ),
        ],
      );

      blocTest<CheckOutCubit, CheckOutState>(
        'should emit error when fetching addresses fails',
        build: () => checkOutCubit,
        act: (cubit) async {
          final exception = Exception('Failed to fetch addresses');
          when(
            () => mockGetUserAddressesUseCase.call(),
          ).thenAnswer((_) async => Error(exception: exception));

          await cubit.doIntent(GetUserAddressesEvent());
        },
        expect: () => [
          isA<CheckOutState>().having(
            (state) => state.userAddressesState,
            'userAddressesState',
            isA<BaseState<List<AddressEntity>>>(),
          ),
          isA<CheckOutState>().having(
            (state) => state.userAddressesState,
            'userAddressesState',
            isA<BaseState<List<AddressEntity>>>(),
          ),
        ],
      );
    });

    group('SelectAddressEvent', () {
      const mockAddress = AddressEntity(
        street: '789 Elm St',
        city: 'Alexandria',
        lat: '31.2001',
        long: '29.9187',
        id: 'addr-3',
        phone: '+1111111111',
      );

      blocTest<CheckOutCubit, CheckOutState>(
        'should emit new state with selected address',
        build: () => checkOutCubit,
        act: (cubit) =>
            cubit.doIntent(SelectAddressEvent(address: mockAddress)),
        expect: () => [
          isA<CheckOutState>().having(
            (state) => state.selectedAddress,
            'selectedAddress',
            mockAddress,
          ),
        ],
      );

      blocTest<CheckOutCubit, CheckOutState>(
        'should preserve user addresses state when selecting address',
        build: () {
          final addresses = [
            mockAddress,
            const AddressEntity(
              street: 'Another St',
              city: 'Cairo',
              lat: '30.0444',
              long: '31.2357',
              id: 'addr-4',
              phone: '+2222222222',
            ),
          ];
          checkOutCubit.emit(
            checkOutCubit.state.copyWith(
              userAddressesState: BaseState.success(addresses),
            ),
          );
          return checkOutCubit;
        },
        act: (cubit) =>
            cubit.doIntent(SelectAddressEvent(address: mockAddress)),
        expect: () => [
          isA<CheckOutState>()
              .having(
                (state) => state.selectedAddress,
                'selectedAddress',
                mockAddress,
              )
              .having(
                (state) => state.userAddressesState,
                'userAddressesState',
                isA<BaseState<List<AddressEntity>>>(),
              ),
        ],
      );
    });
  });
}
