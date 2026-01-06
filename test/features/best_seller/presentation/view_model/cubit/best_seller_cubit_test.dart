import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/entities/product_item_entity.dart';
import 'package:elevate_flower_app/features/best_seller/domain/entities/best_seller_page_entity.dart';
import 'package:elevate_flower_app/features/best_seller/domain/use_cases/get_best_seller_products_use_case.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'best_seller_cubit_test.mocks.dart';

@GenerateMocks([GetBestSellerProductsUseCase])
void main() {
  late BestSellerCubit cubit;
  late MockGetBestSellerProductsUseCase getBestSellerProductsUseCase;
  setUp(() {
    getBestSellerProductsUseCase = MockGetBestSellerProductsUseCase();
    cubit = BestSellerCubit(getBestSellerProductsUseCase);
  });

  group("test best seller cubit", () {
    test("test if initial state is correct", () {
      expect(cubit.state, isA<BestSellerStates>());
    });
    test(
      "emit success state when get best seller products use case returns success",
      () async {
        const dummyData = BestSellerPageEntity(
          currentPage: null,
          totalPages: null,
          products: [
            ProductItemEntity(
              id: '1',
              name: 'name',
              description: 'description',
              price: 1.0,
              priceAfterDiscount: 1.0,
              imageUrl: 'imageUrl',
            ),
          ],
        );
        provideDummy<Result<BestSellerPageEntity>>(
          const Success<BestSellerPageEntity>(data: dummyData),
        );
        when(getBestSellerProductsUseCase()).thenAnswer(
          (_) async => const Success<BestSellerPageEntity>(data: dummyData),
        );
        final registerStatesStream = cubit.stream
            .map((state) => state.getMostSellerState)
            .take(2)
            .toList();
        cubit.doIntent(BestSellerEvents.getBestSellerProducts());
        final states = await registerStatesStream;
        expect(states[0], equals(const BaseState<BestSellerPageEntity>.loading()));
        expect(states[1], equals(const BaseState.success(dummyData)));
        expect(states[1].data, equals(dummyData));
      },
    );
    test(
      "emit error state when get best seller products use case returns error",
      () async {
        final dummyException = Exception();
        provideDummy<Result<BestSellerPageEntity>>(
          Error<BestSellerPageEntity>(exception: dummyException),
        );
        when(
          getBestSellerProductsUseCase(),
        ).thenAnswer((_) async => Error<BestSellerPageEntity>(exception: dummyException));
        final registerStatesStream = cubit.stream
            .map((state) => state.getMostSellerState)
            .take(2)
            .toList();
        cubit.doIntent(BestSellerEvents.getBestSellerProducts());
        final states = await registerStatesStream;
        expect(states[0], equals(const BaseState<BestSellerPageEntity>.loading()));
        expect(
          states[1],
          equals(BaseState<BestSellerPageEntity>.error(dummyException)),
        );
      },
    );
  });
}
