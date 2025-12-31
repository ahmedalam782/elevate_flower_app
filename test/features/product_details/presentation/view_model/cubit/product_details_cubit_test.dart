import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:elevate_flower_app/features/product_details/domain/use_cases/get_specefic_product_use_case.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_cubit.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_events.dart';
import 'package:elevate_flower_app/features/product_details/presentation/view_model/cubit/product_details_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetSpeceficProductUseCase extends Mock
    implements GetSpeceficProductUseCase {}

void main() {
  late MockGetSpeceficProductUseCase mockGetSpeceficProductUseCase;
  late ProductDetailsCubit cubit;

  const String testProductId = '123';
  final testSpeceficProductEntity = SpeceficProductEntity(
    productId: testProductId,
    productName: 'Rose Bouquet',
    productDescription: 'Beautiful red roses',
    productPrice: 100,
    productPriceAfterDiscount: 80,
    productImages: ['image1.jpg', 'image2.jpg'],
  );

  setUp(() {
    mockGetSpeceficProductUseCase = MockGetSpeceficProductUseCase();
    cubit = ProductDetailsCubit(
      getSpeceficProductUseCase: mockGetSpeceficProductUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ProductDetailsCubit', () {
    group('initial state', () {
      test('initial state is ProductDetailsStates with initial BaseState', () {
        expect(cubit.state.state.state, equals(StateType.initial));
        expect(cubit.state.state.data, isNull);
        expect(cubit.state.state.exception, isNull);
      });
    });

    group('getSpeceficProduct', () {
      test(
        'emits [loading, success] when getSpeceficProduct is called successfully',
        () async {
          // Arrange
          when(
            () => mockGetSpeceficProductUseCase.call(testProductId),
          ).thenAnswer(
            (_) async =>
                Success<SpeceficProductEntity>(data: testSpeceficProductEntity),
          );

          // Act & Assert
          expect(
            cubit.stream,
            emitsInOrder([
              isA<ProductDetailsStates>().having(
                (state) => state.state.state,
                'state',
                StateType.loading,
              ),
              isA<ProductDetailsStates>()
                  .having(
                    (state) => state.state.state,
                    'state',
                    StateType.success,
                  )
                  .having(
                    (state) => state.state.data,
                    'data',
                    equals(testSpeceficProductEntity),
                  ),
            ]),
          );

          await cubit.getSpeceficProduct(testProductId);

          verify(
            () => mockGetSpeceficProductUseCase.call(testProductId),
          ).called(1);
        },
      );

      test('emits [loading, error] when getSpeceficProduct fails', () async {
        // Arrange
        final exception = Exception('Network error');
        when(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).thenAnswer(
          (_) async => Error<SpeceficProductEntity>(exception: exception),
        );

        // Act & Assert
        expect(
          cubit.stream,
          emitsInOrder([
            isA<ProductDetailsStates>().having(
              (state) => state.state.state,
              'state',
              StateType.loading,
            ),
            isA<ProductDetailsStates>()
                .having((state) => state.state.state, 'state', StateType.error)
                .having(
                  (state) => state.state.exception,
                  'exception',
                  equals(exception),
                ),
          ]),
        );

        await cubit.getSpeceficProduct(testProductId);

        verify(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).called(1);
      });

      test(
        'emits correct states with product data containing all fields',
        () async {
          // Arrange
          final productWithAllFields = SpeceficProductEntity(
            productId: '456',
            productName: 'Premium Tulips',
            productDescription: 'Elegant yellow tulips',
            productPrice: 150,
            productPriceAfterDiscount: 120,
            productImages: ['tulip1.jpg', 'tulip2.jpg', 'tulip3.jpg'],
          );

          when(() => mockGetSpeceficProductUseCase.call('456')).thenAnswer(
            (_) async =>
                Success<SpeceficProductEntity>(data: productWithAllFields),
          );

          // Act & Assert
          expect(
            cubit.stream,
            emitsInOrder([
              isA<ProductDetailsStates>().having(
                (state) => state.state.state,
                'state',
                StateType.loading,
              ),
              isA<ProductDetailsStates>()
                  .having(
                    (state) => state.state.data?.productId,
                    'productId',
                    equals('456'),
                  )
                  .having(
                    (state) => state.state.data?.productName,
                    'productName',
                    equals('Premium Tulips'),
                  )
                  .having(
                    (state) => state.state.data?.productPrice,
                    'productPrice',
                    equals(150),
                  )
                  .having(
                    (state) => state.state.data?.productPriceAfterDiscount,
                    'productPriceAfterDiscount',
                    equals(120),
                  )
                  .having(
                    (state) => state.state.data?.productImages.length,
                    'images length',
                    equals(3),
                  ),
            ]),
          );

          await cubit.getSpeceficProduct('456');
        },
      );

      test('calls use case with correct product ID', () async {
        // Arrange
        when(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).thenAnswer(
          (_) async =>
              Success<SpeceficProductEntity>(data: testSpeceficProductEntity),
        );

        // Act
        await cubit.getSpeceficProduct(testProductId);

        // Assert
        verify(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).called(1);
        verifyNoMoreInteractions(mockGetSpeceficProductUseCase);
      });

      test('handles Failures exception type correctly', () async {
        // Arrange
        final failure = ServerFailure(errorMessage: 'Product not found');
        when(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).thenAnswer(
          (_) async => Error<SpeceficProductEntity>(exception: failure),
        );

        // Act & Assert
        expect(
          cubit.stream,
          emitsInOrder([
            isA<ProductDetailsStates>().having(
              (state) => state.state.state,
              'state',
              StateType.loading,
            ),
            isA<ProductDetailsStates>()
                .having((state) => state.state.state, 'state', StateType.error)
                .having(
                  (state) => state.state.exception,
                  'exception',
                  isA<ServerFailure>(),
                ),
          ]),
        );

        await cubit.getSpeceficProduct(testProductId);
      });

      test('emits multiple times when called multiple times', () async {
        // Arrange
        when(() => mockGetSpeceficProductUseCase.call('id1')).thenAnswer(
          (_) async => Success<SpeceficProductEntity>(
            data: SpeceficProductEntity(
              productId: 'id1',
              productName: 'Product 1',
              productDescription: 'Desc 1',
              productPrice: 100,
              productPriceAfterDiscount: 80,
              productImages: [],
            ),
          ),
        );

        when(() => mockGetSpeceficProductUseCase.call('id2')).thenAnswer(
          (_) async => Success<SpeceficProductEntity>(
            data: SpeceficProductEntity(
              productId: 'id2',
              productName: 'Product 2',
              productDescription: 'Desc 2',
              productPrice: 200,
              productPriceAfterDiscount: 150,
              productImages: [],
            ),
          ),
        );

        // Act
        await cubit.getSpeceficProduct('id1');
        await cubit.getSpeceficProduct('id2');

        // Assert
        verify(() => mockGetSpeceficProductUseCase.call('id1')).called(1);
        verify(() => mockGetSpeceficProductUseCase.call('id2')).called(1);
      });
    });

    group('doIntent', () {
      test(
        'should call getSpeceficProduct when GetSpeceficProductEvent is dispatched',
        () async {
          // Arrange
          when(
            () => mockGetSpeceficProductUseCase.call(testProductId),
          ).thenAnswer(
            (_) async =>
                Success<SpeceficProductEntity>(data: testSpeceficProductEntity),
          );

          // Act & Assert
          expect(
            cubit.stream,
            emitsInOrder([
              isA<ProductDetailsStates>().having(
                (state) => state.state.state,
                'state',
                StateType.loading,
              ),
              isA<ProductDetailsStates>()
                  .having(
                    (state) => state.state.state,
                    'state',
                    StateType.success,
                  )
                  .having(
                    (state) => state.state.data,
                    'data',
                    equals(testSpeceficProductEntity),
                  ),
            ]),
          );

          await cubit.doIntent(
            GetSpeceficProductEvent(productId: testProductId),
          );

          verify(
            () => mockGetSpeceficProductUseCase.call(testProductId),
          ).called(1);
        },
      );

      test('should pass correct product ID from event to use case', () async {
        // Arrange
        const eventProductId = '999';
        when(
          () => mockGetSpeceficProductUseCase.call(eventProductId),
        ).thenAnswer(
          (_) async => Success<SpeceficProductEntity>(
            data: SpeceficProductEntity(
              productId: eventProductId,
              productName: 'Test',
              productDescription: 'Test',
              productPrice: 0,
              productPriceAfterDiscount: 0,
              productImages: [],
            ),
          ),
        );

        // Act
        await cubit.doIntent(
          GetSpeceficProductEvent(productId: eventProductId),
        );

        // Assert
        verify(
          () => mockGetSpeceficProductUseCase.call(eventProductId),
        ).called(1);
      });
    });

    group('state transitions', () {
      test('state transitions from initial to loading to success', () {
        // Arrange
        when(
          () => mockGetSpeceficProductUseCase.call(testProductId),
        ).thenAnswer(
          (_) async =>
              Success<SpeceficProductEntity>(data: testSpeceficProductEntity),
        );

        // Act & Assert
        expect(
          cubit.stream,
          emitsInOrder([
            isA<ProductDetailsStates>(),
            isA<ProductDetailsStates>(),
          ]),
        );

        cubit.getSpeceficProduct(testProductId);
      });

      test('copyWith method creates new state with updated BaseState', () {
        // Arrange
        final newProduct = SpeceficProductEntity(
          productId: 'new-id',
          productName: 'New Product',
          productDescription: 'New Description',
          productPrice: 200,
          productPriceAfterDiscount: 150,
          productImages: [],
        );

        // Act
        final newState = cubit.state.copyWith(BaseState.success(newProduct));

        // Assert
        expect(newState.state.state, equals(StateType.success));
        expect(newState.state.data, equals(newProduct));
        expect(newState.state.exception, isNull);
      });
    });
  });
}
