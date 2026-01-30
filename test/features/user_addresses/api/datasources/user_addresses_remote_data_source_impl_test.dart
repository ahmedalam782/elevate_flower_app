import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/user_addresses/api/api_client/user_addresses_api_client.dart';
import 'package:elevate_flower_app/features/user_addresses/api/datasources/user_addresses_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/get_all_addresses_response.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/remove_address_response.dart';
import 'package:elevate_flower_app/features/user_addresses/data/models/user_address_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../register/api/datasources/register_remote_data_source_impl_test.mocks.dart';
import 'user_addresses_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([UserAddressesApiClient])
void main() {
  late MockUserAddressesApiClient mockApiClient;
  late UserAddressesRemoteDataSourceImpl dataSource;
  late MockInternetConnection mockInternetConnection;

  setUp(() async {
    await GetIt.instance.reset();

    mockInternetConnection = MockInternetConnection();
    when(
      mockInternetConnection.hasInternetAccess,
    ).thenAnswer((_) async => true);
        GetIt.instance.registerSingleton<InternetConnection>(
      mockInternetConnection,
    );
    mockApiClient = MockUserAddressesApiClient();
    dataSource = UserAddressesRemoteDataSourceImpl(mockApiClient);
  });

  group('getAllAddresses', () {
    test('should return Success when api call is successful', () async {
      // arrange
      final response = GetAllAddressesResponse(
        message: "success",
        addresses: [
          UserAddressDto(id: '123', city: 'New York', street: "123 Main St"),
        ],
      );

      when(mockApiClient.getAllAddresses()).thenAnswer((_) async => response);

      // act
      final result = await dataSource.getAllAddresses();

      // assert
      expect(result, isA<Success<GetAllAddressesResponse>>());
      final success = result as Success<GetAllAddressesResponse>;
      expect(success.data, response);
      verify(mockApiClient.getAllAddresses()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Failure when api throws exception', () async {
      // arrange
      when(
        mockApiClient.getAllAddresses(),
      ).thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.getAllAddresses();

      // assert
      expect(result, isA<Error>());
      verify(mockApiClient.getAllAddresses()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group('removeAddress', () {
    const addressId = '123';

    test('should return Success when api call is successful', () async {
      // arrange
      final response = RemoveAddressResponse(
        message: "success",
        address: [
          UserAddressDto(id: '123', city: 'New York', street: "123 Main St"),
        ],
      );

      when(
        mockApiClient.deleteAddress(addressId),
      ).thenAnswer((_) async => response);

      // act
      final result = await dataSource.removeAddress(addressId);

      // assert
      expect(result, isA<Success<RemoveAddressResponse>>());
      final success = result as Success<RemoveAddressResponse>;
      expect(success.data, response);
      verify(mockApiClient.deleteAddress(addressId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return Failure when api throws exception', () async {
      // arrange
      when(
        mockApiClient.deleteAddress(addressId),
      ).thenThrow(Exception('Delete failed'));

      // act
      final result = await dataSource.removeAddress(addressId);

      // assert
      expect(result, isA<Error>());
      verify(mockApiClient.deleteAddress(addressId)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
