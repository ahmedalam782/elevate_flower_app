import 'package:flutter_test/flutter_test.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/cart/data/models/cart_response.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:elevate_flower_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:elevate_flower_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';

class FakeCartRemoteDataSource implements CartRemoteDataSourceContract {
  Future<Result<CartResponse>> Function()? getCartDataHandler;
  Future<Result<void>> Function(CartProductPostData data)? addProductHandler;
  Future<Result<void>> Function(String productId)? removeProductHandler;
  Future<Result<void>> Function()? clearCartHandler;
  Future<Result<void>> Function(String id, CartUpdateDataModel data)?
  updateQuantityHandler;

  @override
  Future<Result<void>> addProductToCart(CartProductPostData data) =>
      addProductHandler?.call(data) ??
      Future.value(Error<void>(exception: Exception('no handler')));

  @override
  Future<Result<void>> clearUserCart() =>
      clearCartHandler?.call() ??
      Future.value(Error<void>(exception: Exception('no handler')));

  @override
  Future<Result<CartResponse>> getCartData() =>
      getCartDataHandler?.call() ??
      Future.value(Error<CartResponse>(exception: Exception('no handler')));

  @override
  Future<Result<void>> removeProductFromCart(String productId) =>
      removeProductHandler?.call(productId) ??
      Future.value(Error<void>(exception: Exception('no handler')));

  @override
  Future<Result<void>> updateCartQuantity(
    String id,
    CartUpdateDataModel data,
  ) =>
      updateQuantityHandler?.call(id, data) ??
      Future.value(Error<void>(exception: Exception('no handler')));
}

void main() {
  late FakeCartRemoteDataSource fakeRemote;
  late CartRepositoryImpl repository;

  setUp(() {
    fakeRemote = FakeCartRemoteDataSource();
    repository = CartRepositoryImpl(carRemoteDataSourceContract: fakeRemote);
  });

  group('CartRepositoryImpl', () {
    test(
      'getCartData returns Success with mapped CartEntity on success',
      () async {
        final cart = Cart(
          id: null,
          user: null,
          cartItems: [],
          appliedCoupons: [],
          totalPrice: 123,
          createdAt: null,
          updatedAt: null,
          v: 0,
        );
        final response = CartResponse(
          message: 'ok',
          numOfCartItems: 2,
          cart: cart,
        );

        fakeRemote.getCartDataHandler = () =>
            Future.value(Success<CartResponse>(data: response));

        final result = await repository.getCartData();

        expect(result, isA<Success<CartEntity>>());
        final success = result as Success<CartEntity>;
        expect(success.data, isNotNull);
        expect(success.data!.numOfCartItems, 2);
        expect(success.data!.totalPrice, 123);
      },
    );

    test('getCartData returns Error when remote returns Error', () async {
      fakeRemote.getCartDataHandler = () => Future.value(
        Error<CartResponse>(exception: Exception('fetch failed')),
      );

      final result = await repository.getCartData();

      expect(result, isA<Error<CartEntity>>());
      final error = result as Error<CartEntity>;
      expect(error.exception, isA<Exception>());
    });

    test('addProductToCart returns Success on remote success', () async {
      fakeRemote.addProductHandler = (_) => Future.value(const Success<void>());

      final result = await repository.addProductToCart(
        CartProductPostData(product: 'p1', quantity: 1),
      );

      expect(result, isA<Success<void>>());
    });

    test('addProductToCart returns Error on remote error', () async {
      fakeRemote.addProductHandler = (_) =>
          Future.value(Error<void>(exception: Exception('add failed')));

      final result = await repository.addProductToCart(
        CartProductPostData(product: 'p1'),
      );

      expect(result, isA<Error<void>>());
    });

    test('removeProductFromCart returns Success on remote success', () async {
      fakeRemote.removeProductHandler = (_) => Future.value(const Success<void>());

      final result = await repository.removeProductFromCart('id1');

      expect(result, isA<Success<void>>());
    });

    test('removeProductFromCart returns Error on remote error', () async {
      fakeRemote.removeProductHandler = (_) =>
          Future.value(Error<void>(exception: Exception('remove failed')));

      final result = await repository.removeProductFromCart('id1');

      expect(result, isA<Error<void>>());
    });

    test('clearUserCart returns Success on remote success', () async {
      fakeRemote.clearCartHandler = () => Future.value(const Success<void>());

      final result = await repository.clearUserCart();

      expect(result, isA<Success<void>>());
    });

    test('clearUserCart returns Error on remote error', () async {
      fakeRemote.clearCartHandler = () =>
          Future.value(Error<void>(exception: Exception('clear failed')));

      final result = await repository.clearUserCart();

      expect(result, isA<Error<void>>());
    });

    test('updateCartQuantity returns Success on remote success', () async {
      fakeRemote.updateQuantityHandler = (_, __) =>
          Future.value(const Success<void>());

      final result = await repository.updateCartQuantity(
        'id1',
        CartUpdateDataModel(quantity: 2),
      );

      expect(result, isA<Success<void>>());
    });

    test('updateCartQuantity returns Error on remote error', () async {
      fakeRemote.updateQuantityHandler = (_, __) =>
          Future.value(Error<void>(exception: Exception('update failed')));

      final result = await repository.updateCartQuantity(
        'id1',
        CartUpdateDataModel(quantity: 2),
      );

      expect(result, isA<Error<void>>());
    });
  });
}
