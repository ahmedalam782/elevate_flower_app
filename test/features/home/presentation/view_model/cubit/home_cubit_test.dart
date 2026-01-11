import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/home/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/home_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:elevate_flower_app/features/home/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/home/domain/use_cases/get_home_data_usecase.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetHomeDataUsecase])
void main() {
  late HomeCubit homeCubit;
  late MockGetHomeDataUsecase mockGetHomeDataUsecase;

  setUp(() {
    mockGetHomeDataUsecase = MockGetHomeDataUsecase();
    homeCubit = HomeCubit(mockGetHomeDataUsecase);
  });

  group("HomeCubit test", () {
    // Dummy data for testing
    final dummyHomeEntity = HomeEntity(
      products: [
        ProductEntity(
          id: "1",
          title: "Product 1",
          price: 100,
          description: "Product description",
          priceAfterDiscount: 90,
          imgCover: '',
          images: [],
          quantity: 10,
        ),
      ],
      categories: [
        CategoryEntity(id: "1", name: "Category 1", image: "cat_image"),
      ],
      bestSeller: [
        ProductEntity(
          id: "2",
          title: "Best Seller 1",
          price: 200,
          description: "Best seller description",
          priceAfterDiscount: 180,
          imgCover: '',
          images: [],
          quantity: 20,
        ),
      ],
      occasions: [
        OccasionEntity(id: "1", name: "Occasion 1", image: "occ_image"),
      ],
    );

    final dummyException = Exception("Network error");

    // ================== INITIAL STATE TEST ==================
    test("test if initial state is correct", () {
      expect(homeCubit.state, isA<HomeStates>());
      expect(homeCubit.state.categoryState, equals(const BaseState<List<CategoryEntity>>.initial()));
      expect(
        homeCubit.state.bestSellerState,
        equals(const BaseState<List<ProductEntity>>.initial()),
      );
      expect(homeCubit.state.occasionState, equals(const BaseState<List<OccasionEntity>>.initial()));
    });

    // ================== GET ALL DATA TESTS ==================
    group("GetAllDataEvent tests", () {
      test(
        "emit loading then success states for all when GetAllDataEvent is triggered",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Success<HomeEntity>(data: dummyHomeEntity),
          );
          when(
            mockGetHomeDataUsecase(),
          ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

          // Act
          final statesStream = homeCubit.stream.take(2).toList();
          homeCubit.doAction(GetAllDataEvent());
          final states = await statesStream;

          // Assert - Loading state
          expect(states[0].categoryState, equals(const BaseState<List<CategoryEntity>>.loading()));
          expect(states[0].bestSellerState, equals(const BaseState<List<ProductEntity>>.loading()));
          expect(states[0].occasionState, equals(const BaseState<List<OccasionEntity>>.loading()));

          // Assert - Success state
          expect(
            states[1].categoryState,
            equals(BaseState<List<CategoryEntity>>.success(dummyHomeEntity.categories)),
          );
          expect(
            states[1].bestSellerState,
            equals(BaseState<List<ProductEntity>>.success(dummyHomeEntity.bestSeller)),
          );
          expect(
            states[1].occasionState,
            equals(BaseState<List<OccasionEntity>>.success(dummyHomeEntity.occasions)),
          );

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );

      test(
        "emit loading then error states for all when GetAllDataEvent fails",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Error<HomeEntity>(exception: dummyException),
          );
          when(mockGetHomeDataUsecase()).thenAnswer(
            (_) async => Error<HomeEntity>(exception: dummyException),
          );

          // Act
          final statesStream = homeCubit.stream.take(2).toList();
          homeCubit.doAction(GetAllDataEvent());
          final states = await statesStream;

          // Assert - Loading state
          expect(states[0].categoryState, equals(const BaseState<List<CategoryEntity>>.loading()));
          expect(states[0].bestSellerState, equals(const BaseState<List<ProductEntity>>.loading()));
          expect(states[0].occasionState, equals(const BaseState<List<OccasionEntity>>.loading()));

          // Assert - Error state
          expect(
            states[1].categoryState,
            equals(BaseState<List<CategoryEntity>>.error(dummyException)),
          );
          expect(
            states[1].bestSellerState,
            equals(BaseState<List<ProductEntity>>.error(dummyException)),
          );
          expect(
            states[1].occasionState,
            equals(BaseState<List<OccasionEntity>>.error(dummyException)),
          );

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );
    });

    // ================== GET CATEGORIES TESTS ==================
    group("GetCategoriesEvent tests", () {
      test(
        "emit loading then success state for categories when GetCategoriesEvent is triggered",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Success<HomeEntity>(data: dummyHomeEntity),
          );
          when(
            mockGetHomeDataUsecase(),
          ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.categoryState)
              .take(2)
              .toList();
          homeCubit.doAction(GetCategoriesEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<CategoryEntity>>.loading()));
          expect(
            states[1],
            equals(BaseState<List<CategoryEntity>>.success(dummyHomeEntity.categories)),
          );
          expect(states[1].data, equals(dummyHomeEntity.categories));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );

      test(
        "emit loading then error state for categories when GetCategoriesEvent fails",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Error<HomeEntity>(exception: dummyException),
          );
          when(mockGetHomeDataUsecase()).thenAnswer(
            (_) async => Error<HomeEntity>(exception: dummyException),
          );

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.categoryState)
              .take(2)
              .toList();
          homeCubit.doAction(GetCategoriesEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<CategoryEntity>>.loading()));
          expect(states[1], equals(BaseState<List<CategoryEntity>>.error(dummyException)));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );
    });

    // ================== GET BEST SELLER TESTS ==================
    group("GetBestSellerEvent tests", () {
      test(
        "emit loading then success state for bestSeller when GetBestSellerEvent is triggered",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Success<HomeEntity>(data: dummyHomeEntity),
          );
          when(
            mockGetHomeDataUsecase(),
          ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.bestSellerState)
              .take(2)
              .toList();
          homeCubit.doAction(GetBestSellerEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<ProductEntity>>.loading()));
          expect(
            states[1],
            equals(BaseState<List<ProductEntity>>.success(dummyHomeEntity.bestSeller)),
          );
          expect(states[1].data, equals(dummyHomeEntity.bestSeller));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );

      test(
        "emit loading then error state for bestSeller when GetBestSellerEvent fails",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Error<HomeEntity>(exception: dummyException),
          );
          when(mockGetHomeDataUsecase()).thenAnswer(
            (_) async => Error<HomeEntity>(exception: dummyException),
          );

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.bestSellerState)
              .take(2)
              .toList();
          homeCubit.doAction(GetBestSellerEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<ProductEntity>>.loading()));
          expect(states[1], equals(BaseState<List<ProductEntity>>.error(dummyException)));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );
    });

    // ================== GET OCCASIONS TESTS ==================
    group("GetOccasionEvent tests", () {
      test(
        "emit loading then success state for occasions when GetOccasionEvent is triggered",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Success<HomeEntity>(data: dummyHomeEntity),
          );
          when(
            mockGetHomeDataUsecase(),
          ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.occasionState)
              .take(2)
              .toList();
          homeCubit.doAction(GetOccasionEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<OccasionEntity>>.loading()));
          expect(
            states[1],
            equals(BaseState<List<OccasionEntity>>.success(dummyHomeEntity.occasions)),
          );
          expect(states[1].data, equals(dummyHomeEntity.occasions));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );

      test(
        "emit loading then error state for occasions when GetOccasionEvent fails",
        () async {
          // Arrange
          provideDummy<Result<HomeEntity>>(
            Error<HomeEntity>(exception: dummyException),
          );
          when(mockGetHomeDataUsecase()).thenAnswer(
            (_) async => Error<HomeEntity>(exception: dummyException),
          );

          // Act
          final statesStream = homeCubit.stream
              .map((state) => state.occasionState)
              .take(2)
              .toList();
          homeCubit.doAction(GetOccasionEvent());
          final states = await statesStream;

          // Assert
          expect(states[0], equals(const BaseState<List<OccasionEntity>>.loading()));
          expect(states[1], equals(BaseState<List<OccasionEntity>>.error(dummyException)));

          verify(mockGetHomeDataUsecase()).called(1);
        },
      );
    });

    // ================== USECASE CALL COUNT TESTS ==================
    test("verify usecase is called exactly once for each event", () async {
      // Arrange
      provideDummy<Result<HomeEntity>>(
        Success<HomeEntity>(data: dummyHomeEntity),
      );
      when(
        mockGetHomeDataUsecase(),
      ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

      // Act & Assert for GetCategoriesEvent
      await homeCubit.doAction(GetCategoriesEvent());
      verify(mockGetHomeDataUsecase()).called(1);

      reset(mockGetHomeDataUsecase);
      when(
        mockGetHomeDataUsecase(),
      ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

      // Act & Assert for GetBestSellerEvent
      await homeCubit.doAction(GetBestSellerEvent());
      verify(mockGetHomeDataUsecase()).called(1);

      reset(mockGetHomeDataUsecase);
      when(
        mockGetHomeDataUsecase(),
      ).thenAnswer((_) async => Success<HomeEntity>(data: dummyHomeEntity));

      // Act & Assert for GetOccasionEvent
      await homeCubit.doAction(GetOccasionEvent());
      verify(mockGetHomeDataUsecase()).called(1);
    });
  });
}
