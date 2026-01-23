import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/product_entity.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:elevate_flower_app/features/categories/domain/use_cases/get_products_use_case.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_cubit_test.mocks.dart';

@GenerateMocks([GetCategoriesUseCase, GetProductsUseCase])
void main() {
  late CategoriesCubit cubit;
  late MockGetCategoriesUseCase getCategoriesUseCase;
  late MockGetProductsUseCase getProductsUseCase;

  setUp(() {
    getCategoriesUseCase = MockGetCategoriesUseCase();
    getProductsUseCase = MockGetProductsUseCase();
    cubit = CategoriesCubit(
      getCategoriesUseCase: getCategoriesUseCase,
      getProductsUseCase: getProductsUseCase,
    );
  });

  group("test categories cubit", () {
    test("test if initial state is correct", () {
      expect(cubit.state, isA<CategoriesStates>());
    });

    // Test GetCategoriesEvent - Success
    test(
      "emit success state when get categories use case returns success",
      () async {
        final dummyCategories = [
          CategoryEntity(
            id: '1',
            name: 'Flowers',
            image: 'image_url',
          ),
          CategoryEntity(
            id: '2',
            name: 'Plants',
            image: 'image_url_2',
          ),
        ];

        provideDummy<Result<List<CategoryEntity>>>(
          Success<List<CategoryEntity>>(data: dummyCategories),
        );

        when(getCategoriesUseCase.call()).thenAnswer(
          (_) async => Success<List<CategoryEntity>>(data: dummyCategories),
        );

        final statesStream = cubit.stream
            .map((state) => state.category)
            .take(2)
            .toList();

        cubit.onEvent( GetCategoriesEvent());

        final states = await statesStream;

        expect(states[0], equals( const BaseState<List<CategoryEntity>>.loading()));
        expect(states[1], equals(BaseState.success(dummyCategories)));
        expect(states[1].data, equals(dummyCategories));
      },
    );

    // Test GetCategoriesEvent - Error
    test(
      "emit error state when get categories use case returns error",
      () async {
        final dummyException = Exception('Failed to load categories');

        provideDummy<Result<List<CategoryEntity>>>(
          Error<List<CategoryEntity>>(exception: dummyException),
        );

        when(getCategoriesUseCase.call()).thenAnswer(
          (_) async => Error<List<CategoryEntity>>(exception: dummyException),
        );

        final statesStream = cubit.stream
            .map((state) => state.category)
            .take(2)
            .toList();

        cubit.onEvent( GetCategoriesEvent());

        final states = await statesStream;

        expect(states[0], equals( const BaseState<List<CategoryEntity>>.loading()));
        expect(states[1], equals(BaseState<List<CategoryEntity>>.error(dummyException)));
      },
    );

    // Test GetProductsEvent - Success
    test(
      "emit success state when get products use case returns success",
      () async {
        final dummyProducts = [
          ProductEntity(
            id: '1',
            title: 'Rose',
            description: 'Beautiful red rose',
            price: 50.0,
            priceAfterDiscount: 40.0,
            imgCover: 'rose_image',
          ),
          ProductEntity(
            id: '2',
            title: 'Tulip',
            description: 'Fresh tulip',
            price: 30.0,
            priceAfterDiscount: 25.0,
            imgCover: 'tulip_image',
          ),
        ];

        final expectedProductItems = dummyProducts.map((product) => ProductItemEntity(
          id: product.id,
          name: product.title,
          description: product.description,
          price: product.price,
          priceAfterDiscount: product.priceAfterDiscount,
          imageUrl: product.imgCover,
        )).toList();

        provideDummy<Result<List<ProductEntity>>>(
          Success<List<ProductEntity>>(data: dummyProducts),
        );

        when(getProductsUseCase.call('category123')).thenAnswer(
          (_) async => Success<List<ProductEntity>>(data: dummyProducts),
        );

        final statesStream = cubit.stream
            .map((state) => state.productsOfCategory)
            .take(2)
            .toList();

        cubit.onEvent( GetProductsEvent(categoryId: 'category123'));

        final states = await statesStream;

        expect(states[0], equals( const BaseState<List<ProductItemEntity>>.loading()));
        expect(states[1].data?.length, equals(expectedProductItems.length));
        expect(states[1].data?.first.id, equals(expectedProductItems.first.id));
        expect(states[1].data?.first.name, equals(expectedProductItems.first.name));
      },
    );

    // Test GetProductsEvent with empty categoryId
    test(
      "emit success state when get products use case returns success with null categoryId",
      () async {
        final dummyProducts = [
          ProductEntity(
            id: '1',
            title: 'All Products',
            description: 'All available products',
            price: 100.0,
            priceAfterDiscount: 80.0,
            imgCover: 'all_products_image',
          ),
        ];

        provideDummy<Result<List<ProductEntity>>>(
          Success<List<ProductEntity>>(data: dummyProducts),
        );

        when(getProductsUseCase.call(null)).thenAnswer(
          (_) async => Success<List<ProductEntity>>(data: dummyProducts),
        );

        final statesStream = cubit.stream
            .map((state) => state.productsOfCategory)
            .take(2)
            .toList();

        cubit.onEvent( GetProductsEvent(categoryId: ''));

        final states = await statesStream;

        expect(states[0], equals( const BaseState<List<ProductItemEntity>>.loading()));
        expect(states[1].data?.length, equals(1));
      },
    );

    // Test GetProductsEvent - Error
    test(
      "emit error state when get products use case returns error",
      () async {
        final dummyException = Exception('Failed to load products');

        provideDummy<Result<List<ProductEntity>>>(
          Error<List<ProductEntity>>(exception: dummyException),
        );

        when(getProductsUseCase.call('category123')).thenAnswer(
          (_) async => Error<List<ProductEntity>>(exception: dummyException),
        );

        final statesStream = cubit.stream
            .map((state) => state.productsOfCategory)
            .take(2)
            .toList();

        cubit.onEvent( GetProductsEvent(categoryId: 'category123'));

        final states = await statesStream;

        expect(states[0], equals( const BaseState<List<ProductItemEntity>>.loading()));
        expect(states[1], equals(BaseState<List<ProductItemEntity>>.error(dummyException)));
      },
    );

    // Test GetAllDataEvent - Both Success
    test(
      "emit success states when get all data returns both categories and products successfully",
      () async {
        final dummyCategories = [
          CategoryEntity(id: '1', name: 'Flowers', image: 'image'),
        ];

        final dummyProducts = [
          ProductEntity(
            id: '1',
            title: 'Rose',
            description: 'Red rose',
            price: 50.0,
            priceAfterDiscount: 40.0,
            imgCover: 'rose_image',
          ),
        ];

        provideDummy<Result<List<CategoryEntity>>>(
          Success<List<CategoryEntity>>(data: dummyCategories),
        );

        provideDummy<Result<List<ProductEntity>>>(
          Success<List<ProductEntity>>(data: dummyProducts),
        );

        when(getCategoriesUseCase.call()).thenAnswer(
          (_) async => Success<List<CategoryEntity>>(data: dummyCategories),
        );

        when(getProductsUseCase.call(null)).thenAnswer(
          (_) async => Success<List<ProductEntity>>(data: dummyProducts),
        );

        final statesStream = cubit.stream.take(2).toList();

        cubit.onEvent( GetAllDataEvent());

        final states = await statesStream;

        // First state: both loading
        expect(states[0].category, equals( const BaseState<List<CategoryEntity>>.loading()));
        expect(states[0].productsOfCategory, equals( const BaseState<List<ProductItemEntity>>.loading()));

        // Second state: both success
        expect(states[1].category.data, equals(dummyCategories));
        expect(states[1].productsOfCategory.data?.length, equals(1));
      },
    );

    // Test GetAllDataEvent - Categories Error, Products Success
    test(
      "emit error for categories and success for products when categories fails",
      () async {
        final categoriesException = Exception('Categories failed');

        final dummyProducts = [
          ProductEntity(
            id: '1',
            title: 'Rose',
            description: 'Red rose',
            price: 50.0,
            priceAfterDiscount: 40.0,
            imgCover: 'rose_image',
          ),
        ];

        provideDummy<Result<List<CategoryEntity>>>(
          Error<List<CategoryEntity>>(exception: categoriesException),
        );

        provideDummy<Result<List<ProductEntity>>>(
          Success<List<ProductEntity>>(data: dummyProducts),
        );

        when(getCategoriesUseCase.call()).thenAnswer(
          (_) async => Error<List<CategoryEntity>>(exception: categoriesException),
        );

        when(getProductsUseCase.call(null)).thenAnswer(
          (_) async => Success<List<ProductEntity>>(data: dummyProducts),
        );

        final statesStream = cubit.stream.take(2).toList();

        cubit.onEvent( GetAllDataEvent());

        final states = await statesStream;

        expect(states[1].category, equals(BaseState<List<CategoryEntity>>.error(categoriesException)));
        expect(states[1].productsOfCategory.data?.length, equals(1));
      },
    );

    // Test GetAllDataEvent - Both Error
    test(
      "emit error states when both categories and products fail",
      () async {
        final categoriesException = Exception('Categories failed');
        final productsException = Exception('Products failed');

        provideDummy<Result<List<CategoryEntity>>>(
          Error<List<CategoryEntity>>(exception: categoriesException),
        );

        provideDummy<Result<List<ProductEntity>>>(
          Error<List<ProductEntity>>(exception: productsException),
        );

        when(getCategoriesUseCase.call()).thenAnswer(
          (_) async => Error<List<CategoryEntity>>(exception: categoriesException),
        );

        when(getProductsUseCase.call(null)).thenAnswer(
          (_) async => Error<List<ProductEntity>>(exception: productsException),
        );

        final statesStream = cubit.stream.take(2).toList();

        cubit.onEvent( GetAllDataEvent());

        final states = await statesStream;

        expect(states[1].category, equals(BaseState<List<CategoryEntity>>.error(categoriesException)));
        expect(states[1].productsOfCategory, equals(BaseState<List<ProductItemEntity>>.error(productsException)));
      },
    );
  });
}