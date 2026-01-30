import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/search/domain/use_cases/search_products_usecase.dart';
import 'package:elevate_flower_app/features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:elevate_flower_app/features/search/presentation/view_model/cubit/search_events.dart';
import 'package:elevate_flower_app/features/search/presentation/view_model/cubit/search_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks([SearchProductsUseCase])
void main() {
  late SearchCubit cubit;
  late MockSearchProductsUseCase mockSearchProductsUseCase;

  const tProduct = ProductItemEntity(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    imageUrl: 'image1.jpg',
    price: 100,
    priceAfterDiscount: 90,
  );

  setUpAll(() {
    provideDummy<Result<List<ProductItemEntity>>>(
      const Success<List<ProductItemEntity>>(data: []),
    );
  });

  setUp(() {
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    cubit = SearchCubit(mockSearchProductsUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('SearchCubit Tests', () {
    test('initial state is correct', () {
      expect(cubit.state, equals(const SearchStates()));
    });

    group('SearchEvent', () {
      blocTest<SearchCubit, SearchStates>(
        'emits [loading, success] when search is successful',
        build: () {
          when(mockSearchProductsUseCase(any)).thenAnswer(
            (_) async =>
                const Success<List<ProductItemEntity>>(data: [tProduct]),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(SearchEvents.search(keyword: 'rose', limit: 10)),
        expect: () => [
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.loading,
          ),
          isA<SearchStates>()
              .having((s) => s.searchState.state, 'state', StateType.success)
              .having((s) => s.products, 'products', [tProduct])
              .having((s) => s.isLastPage, 'isLastPage', true),
        ],
      );

      blocTest<SearchCubit, SearchStates>(
        'emits [loading, success([])] when search returns empty',
        build: () {
          when(mockSearchProductsUseCase(any)).thenAnswer(
            (_) async => const Success<List<ProductItemEntity>>(data: []),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(SearchEvents.search(keyword: 'unknown', limit: 10)),
        expect: () => [
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.loading,
          ),
          isA<SearchStates>()
              .having((s) => s.searchState.state, 'state', StateType.success)
              .having((s) => s.products, 'products', [])
              .having((s) => s.isLastPage, 'isLastPage', true),
        ],
      );

      blocTest<SearchCubit, SearchStates>(
        'emits [loading, error] when search fails',
        build: () {
          when(mockSearchProductsUseCase(any)).thenAnswer(
            (_) async =>
                Error<List<ProductItemEntity>>(exception: Exception('Error')),
          );
          return cubit;
        },
        act: (cubit) =>
            cubit.doIntent(SearchEvents.search(keyword: 'rose', limit: 10)),
        expect: () => [
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.loading,
          ),
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.error,
          ),
        ],
      );

      blocTest<SearchCubit, SearchStates>(
        'emits initial state when keyword is empty',
        build: () => cubit,
        act: (cubit) =>
            cubit.doIntent(SearchEvents.search(keyword: '', limit: 10)),
        expect: () => [equals(const SearchStates())],
      );
      group('LoadMore Performance', () {
        blocTest<SearchCubit, SearchStates>(
          'emits [moreLoading, success] when load more is successful',
          build: () {
            // Setup initial search result
            when(mockSearchProductsUseCase(any)).thenAnswer(
              (_) async =>
                  const Success<List<ProductItemEntity>>(data: [tProduct]),
            );
            return cubit;
          },
          act: (cubit) async {
            await cubit.doIntent(
              SearchEvents.search(keyword: 'rose', limit: 1),
            ); // limit 1 means it's not last page if it gets 1
            when(mockSearchProductsUseCase(any)).thenAnswer(
              (_) async => Success<List<ProductItemEntity>>(
                data: [tProduct.copyWith(id: '2')],
              ),
            );
            await cubit.doIntent(SearchEvents.loadMore());
          },
          expect: () => [
            isA<SearchStates>().having(
              (s) => s.searchState.state,
              'state',
              StateType.loading,
            ),
            isA<SearchStates>().having(
              (s) => s.searchState.state,
              'state',
              StateType.success,
            ),
            isA<SearchStates>().having(
              (s) => s.searchState.state,
              'state',
              StateType.moreLoading,
            ),
            isA<SearchStates>()
                .having((s) => s.searchState.state, 'state', StateType.success)
                .having((s) => s.products.length, 'products length', 2),
          ],
        );
      });
    });
    group('LoadMore Empty', () {
      blocTest<SearchCubit, SearchStates>(
        'emits [moreLoading, success] and sets isLastPage when load more returns empty',
        build: () {
          when(mockSearchProductsUseCase(any)).thenAnswer(
            (_) async =>
                const Success<List<ProductItemEntity>>(data: [tProduct]),
          );
          return cubit;
        },
        act: (cubit) async {
          await cubit.doIntent(SearchEvents.search(keyword: 'rose', limit: 1));
          when(mockSearchProductsUseCase(any)).thenAnswer(
            (_) async => const Success<List<ProductItemEntity>>(data: []),
          );
          await cubit.doIntent(SearchEvents.loadMore());
        },
        expect: () => [
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.loading,
          ),
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.success,
          ),
          isA<SearchStates>().having(
            (s) => s.searchState.state,
            'state',
            StateType.moreLoading,
          ),
          isA<SearchStates>()
              .having((s) => s.searchState.state, 'state', StateType.success)
              .having((s) => s.isLastPage, 'isLastPage', true),
        ],
      );
    });
  });
}
