import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/datasources/address_details_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/address_details/data/models/address_details_data.dart';
import 'package:elevate_flower_app/features/address_details/data/models/cities_model.dart';
import 'package:elevate_flower_app/features/address_details/data/models/states_model.dart';
import 'package:elevate_flower_app/features/address_details/data/repositories/address_details_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_details_repository_impl_test.mocks.dart';

@GenerateMocks([
  AddressDetailsLocalDataSourceContract,
  AddressDetailsRemoteDataSourceContract,
])
void main() {
  late AddressDetailsRepositoryImpl repository;
  late MockAddressDetailsLocalDataSourceContract mockLocalDataSource;
  late MockAddressDetailsRemoteDataSourceContract mockRemoteDataSource;

  /// ---------------------------------------------------------
  /// Mockito dummy values (REQUIRED for sealed + generic Result)
  /// ---------------------------------------------------------
  setUpAll(() {
    provideDummy<Result<void>>(const Success<void>());
  });

  setUp(() {
    mockLocalDataSource = MockAddressDetailsLocalDataSourceContract();
    mockRemoteDataSource = MockAddressDetailsRemoteDataSourceContract();
    repository = AddressDetailsRepositoryImpl(
      addressDetailsLocalDataSource: mockLocalDataSource,
      addressDetailsRemoteDataSource: mockRemoteDataSource,
    );
  });

  // =========================================================
  // getStates
  // =========================================================
  group('getStates', () {
    test('returns list of StatesModel from local data source', () async {
      // Arrange
      final mockStates = [
        StatesModel(
          id: '1',
          governorateId: 'gov_1',
          nameAr: 'القاهرة',
          nameEn: 'Cairo',
        ),
        StatesModel(
          id: '2',
          governorateId: 'gov_1',
          nameAr: 'مدينة نصر',
          nameEn: 'Nasr City',
        ),
        StatesModel(
          id: '3',
          governorateId: 'gov_2',
          nameAr: 'الإسكندرية',
          nameEn: 'Alexandria',
        ),
      ];

      when(
        mockLocalDataSource.getAllStates(),
      ).thenAnswer((_) async => mockStates);

      // Act
      final result = await repository.getStates();

      // Assert
      expect(result, mockStates);
      expect(result.length, 3);
      expect(result[0].nameEn, 'Cairo');
      expect(result[0].nameAr, 'القاهرة');
      expect(result[1].nameEn, 'Nasr City');
      expect(result[2].nameEn, 'Alexandria');

      verify(mockLocalDataSource.getAllStates()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
      'returns empty list when local data source returns empty list',
      () async {
        // Arrange
        when(mockLocalDataSource.getAllStates()).thenAnswer((_) async => []);

        // Act
        final result = await repository.getStates();

        // Assert
        expect(result, isEmpty);

        verify(mockLocalDataSource.getAllStates()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      },
    );
  });

  // =========================================================
  // getAllCities
  // =========================================================
  group('getAllCities', () {
    test('returns list of CityModel from local data source', () async {
      // Arrange
      final mockCities = [
        CityModel(id: '1', nameAr: 'القاهرة', nameEn: 'Cairo'),
        CityModel(id: '2', nameAr: 'الإسكندرية', nameEn: 'Alexandria'),
        CityModel(id: '3', nameAr: 'الجيزة', nameEn: 'Giza'),
      ];

      when(
        mockLocalDataSource.getAllCitites(),
      ).thenAnswer((_) async => mockCities);

      // Act
      final result = await repository.getAllCities();

      // Assert
      expect(result, mockCities);
      expect(result.length, 3);
      expect(result[0].nameEn, 'Cairo');
      expect(result[0].nameAr, 'القاهرة');
      expect(result[1].nameEn, 'Alexandria');
      expect(result[2].nameEn, 'Giza');

      verify(mockLocalDataSource.getAllCitites()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test(
      'returns empty list when local data source returns empty list',
      () async {
        // Arrange
        when(mockLocalDataSource.getAllCitites()).thenAnswer((_) async => []);

        // Act
        final result = await repository.getAllCities();

        // Assert
        expect(result, isEmpty);

        verify(mockLocalDataSource.getAllCitites()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      },
    );
  });

  // =========================================================
  // addAddressDetails
  // =========================================================
  group('addAddressDetails', () {
    final addressData = AddressDetailsData(
      street: '123 Test Street',
      username: 'John Doe',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      phone: '+201234567890',
    );

    test('returns Success<void> when remote returns Success<void>', () async {
      // Arrange
      when(
        mockRemoteDataSource.addAddressDetails(addressData),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.addAddressDetails(addressData);

      // Assert
      expect(result, isA<Success<void>>());

      verify(mockRemoteDataSource.addAddressDetails(addressData)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('returns Error<void> when remote returns Error<void>', () async {
      // Arrange
      final exception = Exception('Failed to add address');

      when(
        mockRemoteDataSource.addAddressDetails(addressData),
      ).thenAnswer((_) async => Error<void>(exception: exception));

      // Act
      final result = await repository.addAddressDetails(addressData);

      // Assert
      expect(result, isA<Error<void>>());

      final error = result as Error<void>;
      expect(error.exception, exception);

      verify(mockRemoteDataSource.addAddressDetails(addressData)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('handles address data with null values', () async {
      // Arrange
      final addressDataWithNulls = AddressDetailsData(
        street: '123 Test Street',
        username: null,
        city: null,
        lat: null,
        long: null,
        phone: null,
      );

      when(
        mockRemoteDataSource.addAddressDetails(addressDataWithNulls),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.addAddressDetails(addressDataWithNulls);

      // Assert
      expect(result, isA<Success<void>>());

      verify(
        mockRemoteDataSource.addAddressDetails(addressDataWithNulls),
      ).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });

  // =========================================================
  // updateAddress
  // =========================================================
  group('updateAddress', () {
    const addressId = 'address_123';
    final addressData = AddressDetailsData(
      addressId: addressId,
      street: '456 Updated Street',
      username: 'Jane Smith',
      city: 'Alexandria',
      lat: '31.2001',
      long: '29.9187',
      phone: '+201987654321',
    );

    test('returns Success<void> when remote returns Success<void>', () async {
      // Arrange
      when(
        mockRemoteDataSource.updateAddress(addressData, addressId),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.updateAddress(addressData, addressId);

      // Assert
      expect(result, isA<Success<void>>());

      verify(
        mockRemoteDataSource.updateAddress(addressData, addressId),
      ).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('returns Error<void> when remote returns Error<void>', () async {
      // Arrange
      final exception = Exception('Failed to update address');

      when(
        mockRemoteDataSource.updateAddress(addressData, addressId),
      ).thenAnswer((_) async => Error<void>(exception: exception));

      // Act
      final result = await repository.updateAddress(addressData, addressId);

      // Assert
      expect(result, isA<Error<void>>());

      final error = result as Error<void>;
      expect(error.exception, exception);

      verify(
        mockRemoteDataSource.updateAddress(addressData, addressId),
      ).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('handles partial address data update', () async {
      // Arrange
      final partialAddressData = AddressDetailsData(
        street: '789 Partial Street',
        username: 'Ahmed Ali',
        city: null,
        lat: null,
        long: null,
        phone: null,
      );

      when(
        mockRemoteDataSource.updateAddress(partialAddressData, addressId),
      ).thenAnswer((_) async => const Success<void>());

      // Act
      final result = await repository.updateAddress(
        partialAddressData,
        addressId,
      );

      // Assert
      expect(result, isA<Success<void>>());

      verify(
        mockRemoteDataSource.updateAddress(partialAddressData, addressId),
      ).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });
}
