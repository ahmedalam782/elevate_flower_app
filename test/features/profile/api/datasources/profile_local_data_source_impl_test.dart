import 'dart:convert';
import 'package:elevate_flower_app/features/profile/api/datasources/profile_local_data_source_impl.dart';
import 'package:elevate_flower_app/features/profile/domain/entities/profile_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProfileLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProfileLocalDataSourceImpl(mockSharedPreferences);
  });

  group("ProfileLocalDataSourceImpl Tests", () {
    final testEntity = ProfileDataEntity(
      id: "1",
      firstName: "John",
      lastName: "Doe",
      email: "john@example.com",
      gender: "male",
      phone: "1234567890",
      photo: "https://example.com/photo.jpg",
      role: "user",
      wishlist: [],
      addresses: [],
      createdAt: "2024-01-15",
    );

    final testEntityJson = {
      'id': "1",
      'firstName': "John",
      'lastName': "Doe",
      'email': "john@example.com",
      'gender': "male",
      'phone': "1234567890",
      'photo': "https://example.com/photo.jpg",
      'role': "user",
      'wishlist': [],
      'addresses': [],
      'createdAt': "2024-01-15",
    };

    group("saveProfileData", () {
      test("saves profile data to SharedPreferences successfully", () async {
        // Arrange
        when(
          mockSharedPreferences.setString(any, any),
        ).thenAnswer((_) async => true);

        // Act
        await dataSource.saveProfileData(testEntity);

        // Assert
        verify(
          mockSharedPreferences.setString(
            'cached_profile_data',
            json.encode(testEntityJson),
          ),
        ).called(1);
      });

      test("handles save failure gracefully", () async {
        // Arrange
        when(
          mockSharedPreferences.setString(any, any),
        ).thenThrow(Exception("Storage error"));

        // Act & Assert
        expect(() => dataSource.saveProfileData(testEntity), throwsException);
      });
    });

    group("getProfileData", () {
      test("returns ProfileDataEntity when data exists in cache", () async {
        // Arrange
        final jsonString = json.encode(testEntityJson);
        when(
          mockSharedPreferences.getString('cached_profile_data'),
        ).thenReturn(jsonString);

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isNotNull);
        expect(result?.id, testEntity.id);
        expect(result?.firstName, testEntity.firstName);
        expect(result?.lastName, testEntity.lastName);
        expect(result?.email, testEntity.email);
        expect(result?.gender, testEntity.gender);
        expect(result?.phone, testEntity.phone);
        expect(result?.fullName, "John Doe");

        verify(
          mockSharedPreferences.getString('cached_profile_data'),
        ).called(1);
      });

      test("returns null when no data exists in cache", () async {
        // Arrange
        when(
          mockSharedPreferences.getString('cached_profile_data'),
        ).thenReturn(null);

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isNull);
        verify(
          mockSharedPreferences.getString('cached_profile_data'),
        ).called(1);
      });

      test("returns null when cached data is invalid JSON", () async {
        // Arrange
        when(
          mockSharedPreferences.getString('cached_profile_data'),
        ).thenReturn("invalid json");

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isNull);
        verify(
          mockSharedPreferences.getString('cached_profile_data'),
        ).called(1);
      });

      test("returns null when cached data has missing fields", () async {
        // Arrange
        final incompleteJson = json.encode({
          'id': "1",
          'firstName': "John",
          // Missing other required fields
        });
        when(
          mockSharedPreferences.getString('cached_profile_data'),
        ).thenReturn(incompleteJson);

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isNull);
      });

      test("handles complex data types in wishlist and addresses", () async {
        // Arrange
        final jsonData = {
          'id': "1",
          'firstName': "John",
          'lastName': "Doe",
          'email': "john@example.com",
          'gender': "male",
          'phone': "1234567890",
          'photo': "https://example.com/photo.jpg",
          'role': "user",
          'wishlist': ["item1", "item2"],
          'addresses': [
            {"street": "123 Main St", "city": "Cairo"},
          ],
          'createdAt': "2024-01-15",
        };

        when(
          mockSharedPreferences.getString('cached_profile_data'),
        ).thenReturn(json.encode(jsonData));

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isNotNull);
        expect(result?.wishlist.length, 2);
        expect(result?.addresses.length, 1);
      });
    });

    group("clearProfileData", () {
      test(
        "removes profile data from SharedPreferences successfully",
        () async {
          // Arrange
          when(
            mockSharedPreferences.remove('cached_profile_data'),
          ).thenAnswer((_) async => true);

          // Act
          await dataSource.clearProfileData();

          // Assert
          verify(mockSharedPreferences.remove('cached_profile_data')).called(1);
        },
      );

      test("handles clear failure gracefully", () async {
        // Arrange
        when(
          mockSharedPreferences.remove('cached_profile_data'),
        ).thenThrow(Exception("Storage error"));

        // Act & Assert
        expect(() => dataSource.clearProfileData(), throwsException);
      });
    });
  });
}
