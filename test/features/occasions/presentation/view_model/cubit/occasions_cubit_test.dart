import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';
import 'package:elevate_flower_app/features/occasions/domain/use_cases/get_occasions_use_case.dart';
import 'package:elevate_flower_app/features/occasions/domain/use_cases/get_products_by_occasion_use_case.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasions_cubit_test.mocks.dart';

class TestException implements Exception {
  final String message;
  const TestException(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

@GenerateMocks([GetOccasionsUseCase, GetProductsByOccasionUseCase])
void main() {
  late OccasionsCubit cubit;
  late MockGetOccasionsUseCase mockGetOccasionsUseCase;
  late MockGetProductsByOccasionUseCase mockGetProductsByOccasionUseCase;

  setUp(() {
    mockGetOccasionsUseCase = MockGetOccasionsUseCase();
    mockGetProductsByOccasionUseCase = MockGetProductsByOccasionUseCase();
    cubit = OccasionsCubit(
      mockGetOccasionsUseCase,
      mockGetProductsByOccasionUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  setUpAll(() {
    provideDummy<Result<List<OccasionCardEntity>>>(const Success(data: []));
    provideDummy<Result<List<ProductItemEntity>>>(const Success(data: []));
  });

  group('OccasionsCubit', () {
    final testOccasions = <OccasionCardEntity>[
      OccasionCardEntity(
        id: '1',
        name: 'Birthday',
        image: 'birthday.jpg',
        productsCount: 10,
      ),
      OccasionCardEntity(
        id: '2',
        name: 'Wedding',
        image: 'wedding.jpg',
        productsCount: 5,
      ),
    ];

    final testProducts = <ProductItemEntity>[
      const ProductItemEntity(
        id: '1',
        name: 'Rose Bouquet',
        price: 5000.0,
        imageUrl: 'rose.jpg',
      ),
      const ProductItemEntity(
        id: '2',
        name: 'Tulip Bouquet',
        price: 4000.0,
        imageUrl: 'tulip.jpg',
      ),
    ];

    group('doIntent', () {
      blocTest<OccasionsCubit, OccasionsStates>(
        'should call _getOccasions when GetOccasionsEvent is passed',
        setUp: () {
          when(
            mockGetOccasionsUseCase.call(),
          ).thenAnswer((_) async => Success(data: testOccasions));
          when(
            mockGetProductsByOccasionUseCase.call('1'),
          ).thenAnswer((_) async => const Success(data: []));
        },
        build: () {
          when(
            mockGetOccasionsUseCase.call(),
          ).thenAnswer((_) async => Success(data: testOccasions));
          when(
            mockGetProductsByOccasionUseCase.call('1'),
          ).thenAnswer((_) async => const Success(data: []));
          return cubit;
        },

        act: (cubit) => cubit.doIntent(OccasionsEvents.getOccasions()),
        expect: () => [
          const OccasionsStates(
            occasions: BaseState.loading(),
            productsByOccasion: BaseState.initial(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: const BaseState.initial(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: const BaseState.loading(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: const BaseState.success([]),
          ),
        ],
        verify: (cubit) {
          verify(mockGetOccasionsUseCase.call()).called(1);
        },
      );

      blocTest<OccasionsCubit, OccasionsStates>(
        'should call _getFlowersByOccasion when GetFlowersByOccasionsEvent is passed',
        build: () {
          when(
            mockGetProductsByOccasionUseCase.call('test-id'),
          ).thenAnswer((_) async => const Success(data: []));
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(OccasionsEvents.changeSelectedOccasion('test-id')),
        expect: () => [
          const OccasionsStates(
            occasions: BaseState.initial(),
            productsByOccasion: BaseState.loading(),
          ),
          const OccasionsStates(
            occasions: BaseState.initial(),
            productsByOccasion: BaseState.success([]),
          ),
        ],
        verify: (cubit) {
          verify(mockGetProductsByOccasionUseCase.call('test-id')).called(1);
        },
      );
    });

    group('_getOccasions', () {
      blocTest<OccasionsCubit, OccasionsStates>(
        'emits [loading, success] when getOccasions succeeds and automatically fetches first occasion products',
        build: () {
          when(
            mockGetOccasionsUseCase.call(),
          ).thenAnswer((_) async => Success(data: testOccasions));
          when(
            mockGetProductsByOccasionUseCase.call('1'),
          ).thenAnswer((_) async => Success(data: testProducts));
          return cubit;
        },
        act: (cubit) => cubit.doIntent(OccasionsEvents.getOccasions()),
        expect: () => [
          const OccasionsStates(
            occasions: BaseState.loading(),
            productsByOccasion: BaseState.initial(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: const BaseState.initial(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: const BaseState.loading(),
          ),
          OccasionsStates(
            occasions: BaseState.success(testOccasions),
            productsByOccasion: BaseState.success(testProducts),
          ),
        ],
        verify: (cubit) {
          verify(mockGetOccasionsUseCase.call()).called(1);
          verify(mockGetProductsByOccasionUseCase.call('1')).called(1);
          expect(cubit.selectedOccasionId, '1');
        },
      );

      blocTest<OccasionsCubit, OccasionsStates>(
        'emits [loading, error] when getOccasions fails',
        build: () {
          const exception = TestException('Network error');
          when(
            mockGetOccasionsUseCase.call(),
          ).thenAnswer((_) async => const Error(exception: exception));
          return cubit;
        },
        act: (cubit) => cubit.doIntent(OccasionsEvents.getOccasions()),
        expect: () {
          const exception = TestException('Network error');
          return [
            const OccasionsStates(
              occasions: BaseState.loading(),
              productsByOccasion: BaseState.initial(),
            ),
            const OccasionsStates(
              occasions: BaseState.error(exception),
              productsByOccasion: BaseState.initial(),
            ),
          ];
        },
        verify: (cubit) {
          verify(mockGetOccasionsUseCase.call()).called(1);
          verifyNever(mockGetProductsByOccasionUseCase.call(any));
        },
      );

      blocTest<OccasionsCubit, OccasionsStates>(
        'handles empty occasions list and does not fetch products',
        build: () {
          when(
            mockGetOccasionsUseCase.call(),
          ).thenAnswer((_) async => const Success(data: []));
          return cubit;
        },
        act: (cubit) => cubit.doIntent(OccasionsEvents.getOccasions()),
        expect: () => [
          const OccasionsStates(
            occasions: BaseState.loading(),
            productsByOccasion: BaseState.initial(),
          ),
          const OccasionsStates(
            occasions: BaseState.success([]),
            productsByOccasion: BaseState.initial(),
          ),
        ],
        verify: (cubit) {
          verify(mockGetOccasionsUseCase.call()).called(1);
          verifyNever(mockGetProductsByOccasionUseCase.call(any));
        },
      );
    });

    group('_getFlowersByOccasion', () {
      const occasionId = 'test-occasion-id';
      final testProducts = <ProductItemEntity>[
        const ProductItemEntity(
          id: '1',
          name: 'Rose Bouquet',
          price: 5000.0,
          imageUrl: 'rose.jpg',
        ),
        const ProductItemEntity(
          id: '2',
          name: 'Tulip Bouquet',
          price: 4000.0,
          imageUrl: 'tulip.jpg',
        ),
      ];

      blocTest<OccasionsCubit, OccasionsStates>(
        'emits [loading, success] when getProductsByOccasion succeeds',
        build: () {
          when(
            mockGetProductsByOccasionUseCase.call(occasionId),
          ).thenAnswer((_) async => Success(data: testProducts));
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(OccasionsEvents.changeSelectedOccasion(occasionId)),
        expect: () => [
          const OccasionsStates(
            occasions: BaseState.initial(),
            productsByOccasion: BaseState.loading(),
          ),
          OccasionsStates(
            occasions: const BaseState.initial(),
            productsByOccasion: BaseState.success(testProducts),
          ),
        ],
        verify: (cubit) {
          verify(mockGetProductsByOccasionUseCase.call(occasionId)).called(1);
          expect(cubit.selectedOccasionId, occasionId);
        },
      );

      blocTest<OccasionsCubit, OccasionsStates>(
        'emits [loading, error] when getProductsByOccasion fails',
        build: () {
          const exception = TestException('API error');
          when(
            mockGetProductsByOccasionUseCase.call(occasionId),
          ).thenAnswer((_) async => const Error(exception: exception));
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(OccasionsEvents.changeSelectedOccasion(occasionId)),
        expect: () {
          const exception = TestException('API error');
          return [
            const OccasionsStates(
              occasions: BaseState.initial(),
              productsByOccasion: BaseState.loading(),
            ),
            const OccasionsStates(
              occasions: BaseState.initial(),
              productsByOccasion: BaseState.error(exception),
            ),
          ];
        },
        verify: (cubit) {
          verify(mockGetProductsByOccasionUseCase.call(occasionId)).called(1);
          expect(cubit.selectedOccasionId, occasionId);
        },
      );

      blocTest<OccasionsCubit, OccasionsStates>(
        'updates selectedOccasionId when called',
        build: () {
          when(
            mockGetProductsByOccasionUseCase.call(occasionId),
          ).thenAnswer((_) async => const Success(data: []));
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(OccasionsEvents.changeSelectedOccasion(occasionId)),
        verify: (cubit) {
          expect(cubit.selectedOccasionId, occasionId);
        },
      );
    });

    group('initial state', () {
      test(
        'should have initial state with BaseState.initial for both occasions and productsByOccasion',
        () {
          expect(cubit.state.occasions.state, StateType.initial);
          expect(cubit.state.productsByOccasion.state, StateType.initial);
          expect(cubit.selectedOccasionId, '');
        },
      );
    });
  });
}
