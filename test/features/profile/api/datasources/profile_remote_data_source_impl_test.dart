import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/profile/api/api_client/profile_api_client.dart';
import 'package:elevate_flower_app/features/profile/api/datasources/profile_remote_data_source_impl.dart';
import 'package:elevate_flower_app/features/profile/data/models/profile_data_model.dart';
import 'package:elevate_flower_app/features/profile/data/models/profile_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockProfileApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockApiClient);
  });

  group("ProfileRemoteDataSourceImpl Tests", () {
    final testProfileData = ProfileDataModel(
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

    final testResponse = ProfileResponseModel(
      message: "Profile fetched successfully",
      user: testProfileData,
    );

    group("getProfileData", () {
      test("returns Success when API call succeeds", () async {
        // Arrange
        when(
          mockApiClient.getProfileData(),
        ).thenAnswer((_) async => testResponse);

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isA<Success<ProfileResponseModel>>());
        result.when(
          success: (data) {
            expect(data, testResponse);
            expect(data?.message, "Profile fetched successfully");
            expect(data?.user.firstName, "John");
            expect(data?.user.lastName, "Doe");
          },
          error: (_) => fail('Expected success but got error'),
        );

        verify(mockApiClient.getProfileData()).called(1);
      });

      test("returns Error when API call throws exception", () async {
        // Arrange
        final exception = Exception("Network error");
        when(mockApiClient.getProfileData()).thenThrow(exception);

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isA<Error<ProfileResponseModel>>());
        result.when(
          success: (_) => fail('Expected error but got success'),
          error: (error) {
            expect(error.toString(), contains("Network error"));
          },
        );

        verify(mockApiClient.getProfileData()).called(1);
      });

      test("handles timeout exception", () async {
        // Arrange
        when(
          mockApiClient.getProfileData(),
        ).thenThrow(Exception("Connection timeout"));

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isA<Error<ProfileResponseModel>>());
        result.when(
          success: (_) => fail('Expected error but got success'),
          error: (error) {
            expect(error.toString(), contains("Connection timeout"));
          },
        );
      });

      test("handles server error exception", () async {
        // Arrange
        when(
          mockApiClient.getProfileData(),
        ).thenThrow(Exception("500 Internal Server Error"));

        // Act
        final result = await dataSource.getProfileData();

        // Assert
        expect(result, isA<Error<ProfileResponseModel>>());
        result.when(
          success: (_) => fail('Expected error but got success'),
          error: (error) {
            expect(error.toString(), contains("500 Internal Server Error"));
          },
        );
      });
    });
  });
}
