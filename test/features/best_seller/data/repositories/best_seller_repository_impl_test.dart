import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/best_seller/api/datasources/best_seller_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_model.dart';
import 'package:elevate_flower_app/features/best_seller/data/models/best_seller_response_model.dart';
import 'package:elevate_flower_app/features/best_seller/data/repositories/best_seller_repository_impl.dart';
import 'package:elevate_flower_app/features/best_seller/domain/entities/best_seller_page_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'best_seller_repository_impl_test.mocks.dart';

@GenerateMocks([BestSellerRemoteDataSourceImpl])
void main() {
  late BestSellerRepositoryImpl repository;
  late MockBestSellerRemoteDataSourceImpl mockRemoteDataSource;
  setUp(() {
    mockRemoteDataSource = MockBestSellerRemoteDataSourceImpl();
    repository = BestSellerRepositoryImpl(mockRemoteDataSource);
  });

  group("test remote data source implementation", () {
    test("test getBestSellers in success case", () async {
      final dummyResponse = BestSellerResponseModel(
        message: "success",
        metadata: null,
        bestSellerList: [
          BestSellerModel(
            id: "1",
            title: "name",
            imgCover: "image",
            price: 100,
          ),
        ],
      );
      provideDummy<Result<BestSellerResponseModel>>(
        const Success<BestSellerResponseModel>(),
      );
      when(
        mockRemoteDataSource.getBestSellerProducts(),
      ).thenAnswer((_) async => Success(data: dummyResponse));
      final result = await repository.getBestSellerProducts();
      expect(result, isA<Success<BestSellerPageEntity>>());
      final success = result as Success<BestSellerPageEntity>;
      expect(success.data?.products?[0], dummyResponse.toEntity().products?[0]);
    });

    test("test getBestSellers in error case", () async {
      provideDummy<Result<BestSellerResponseModel>>(
        Error(exception: Exception("error")),
      );
      when(
        mockRemoteDataSource.getBestSellerProducts(),
      ).thenAnswer((_) async => Error(exception: Exception("error")));
      final result = await repository.getBestSellerProducts();
      expect(result, isA<Error<BestSellerPageEntity>>());
      final error = result as Error<BestSellerPageEntity>;
      expect(error.exception, isA<Exception>());
    });
  });
}
