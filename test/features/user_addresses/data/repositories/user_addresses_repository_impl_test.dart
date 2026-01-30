import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/data/datasources/user_addresses_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/get_all_addresses_response.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/remove_address_response.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/user_address_dto.dart';
import 'package:elevate_flower_app/features/user_addresses/data/repositories/user_addresses_repository_impl.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_addresses_repository_impl_test.mocks.dart';

@GenerateMocks([UserAddressesRemoteDataSourceContract])
void main() {
  late MockUserAddressesRemoteDataSourceContract mockRemoteDataSource;
  late UserAddressesRepositoryImpl repository;
  late UserAddressDto dto1;
  late UserAddressDto dto2;

  provideDummy<Result<GetAllAddressesResponse>>(
    Success(data: GetAllAddressesResponse(addresses: [])),
  );

  provideDummy<Result<RemoveAddressResponse>>(
    Success(data: RemoveAddressResponse(address: [])),
  );

  setUp(() {
    mockRemoteDataSource = MockUserAddressesRemoteDataSourceContract();
    repository = UserAddressesRepositoryImpl(mockRemoteDataSource);
    dto1 = UserAddressDto(street: "123 Main St", city: "New York", id: "1");
    dto2 = UserAddressDto(street: "456 Elm St", city: "Los Angeles", id: "2");
  });

  group('deleteAddress', () {
    const id = '123';

    test(
      'should return Success<List<UserAddressEntity>> when remote call is successful',
      () async {
        final response = RemoveAddressResponse(address: [dto1, dto2]);

        when(
          mockRemoteDataSource.removeAddress(id),
        ).thenAnswer((_) async => Success(data: response));

        // act
        final result = await repository.deleteAddress(id);

        // assert
        expect(result, isA<Success<List<UserAddressEntity>>>());
        final success = result as Success<List<UserAddressEntity>>;
        expect(success.data, isA<List<UserAddressEntity>>());
        expect(success.data!.length, 2);
        verify(mockRemoteDataSource.removeAddress(id)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('should return Error when remote call fails', () async {
      // arrange
      final exception = Exception('Delete error');

      when(
        mockRemoteDataSource.removeAddress(id),
      ).thenAnswer((_) async => Error(exception: exception));

      // act
      final result = await repository.deleteAddress(id);

      // assert
      expect(result, isA<Error>());
      final error = result as Error;
      expect(error.exception, exception);
      verify(mockRemoteDataSource.removeAddress(id)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getAllAddresses', () {
    test(
      'should return Success<List<UserAddressEntity>> when remote call is successful',
      () async {
        final response = GetAllAddressesResponse(addresses: [dto1, dto2]);

        when(
          mockRemoteDataSource.getAllAddresses(),
        ).thenAnswer((_) async => Success(data: response));

        // act
        final result = await repository.getAllAddresses();

        // assert
        expect(result, isA<Success<List<UserAddressEntity>>>());
        final success = result as Success<List<UserAddressEntity>>;
        expect(success.data, isA<List<UserAddressEntity>>());
        expect(success.data!.length, 2);
        verify(mockRemoteDataSource.getAllAddresses()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('should return Error when remote call fails', () async {
      // arrange
      final exception = Exception('Fetch error');

      when(
        mockRemoteDataSource.getAllAddresses(),
      ).thenAnswer((_) async => Error(exception: exception));

      // act
      final result = await repository.getAllAddresses();

      // assert
      expect(result, isA<Error>());
      final error = result as Error;
      expect(error.exception, exception);
      verify(mockRemoteDataSource.getAllAddresses()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
