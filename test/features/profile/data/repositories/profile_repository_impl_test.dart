import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/profile/data/datasources/profile_local_data_source_contract.dart';
import 'package:elevate_flower_app/features/profile/data/datasources/profile_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/profile/data/models/profile_data_model.dart';
import 'package:elevate_flower_app/features/profile/data/models/profile_response_model.dart';
import 'package:elevate_flower_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:elevate_flower_app/features/profile/domain/entities/profile_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([
  ProfileRemoteDataSourceContract,
  ProfileLocalDataSourceContract,
])
void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDataSourceContract mockRemoteDataSource;
  late MockProfileLocalDataSourceContract mockLocalDataSource;

  setUpAll(() {
    provideDummy<Result<ProfileResponseModel>>(
      Success<ProfileResponseModel>(
        data: ProfileResponseModel(
          message: "dummy",
          user: ProfileDataModel(
            id: "dummy",
            firstName: "dummy",
            lastName: "dummy",
            email: "dummy@test.com",
            gender: "male",
            phone: "0000",
            photo: "",
            role: "user",
            wishlist: [],
            addresses: [],
            createdAt: "2024-01-01",
          ),
        ),
      ),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSourceContract();
    mockLocalDataSource = MockProfileLocalDataSourceContract();
    repository = ProfileRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group("ProfileRepositoryImpl Tests", () {
    final testModel = ProfileDataModel(
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
      user: testModel,
    );

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

    group("getProfileData", () {
      test(
        "returns remote data and saves to cache when remote call is successful",
        () async {
          // Arrange
          when(
            mockLocalDataSource.getProfileData(),
          ).thenAnswer((_) async => null);
          when(mockRemoteDataSource.getProfileData()).thenAnswer(
            (_) async => Success<ProfileResponseModel>(data: testResponse),
          );
          when(
            mockLocalDataSource.saveProfileData(any),
          ).thenAnswer((_) async => {});

          // Act
          final result = await repository.getProfileData();

          // Assert
          expect(result, isA<Success<ProfileDataEntity>>());
          result.when(
            success: (data) {
              expect(data?.id, testEntity.id);
              expect(data?.firstName, testEntity.firstName);
              expect(data?.lastName, testEntity.lastName);
              expect(data?.email, testEntity.email);
            },
            error: (_) => fail('Expected success but got error'),
          );

          verify(mockRemoteDataSource.getProfileData()).called(1);
          verify(mockLocalDataSource.saveProfileData(any)).called(1);
        },
      );

      test("returns cached data when remote call fails", () async {
        // Arrange
        when(
          mockLocalDataSource.getProfileData(),
        ).thenAnswer((_) async => testEntity);
        when(mockRemoteDataSource.getProfileData()).thenAnswer(
          (_) async => Error<ProfileResponseModel>(
            exception: Exception("Network error"),
          ),
        );

        // Act
        final result = await repository.getProfileData();

        // Assert
        expect(result, isA<Success<ProfileDataEntity>>());
        result.when(
          success: (data) {
            expect(data, testEntity);
            expect(data?.fullName, "John Doe");
          },
          error: (_) => fail('Expected success but got error'),
        );

        verify(mockRemoteDataSource.getProfileData()).called(1);
        verify(mockLocalDataSource.getProfileData()).called(1);
        verifyNever(mockLocalDataSource.saveProfileData(any));
      });

      test("returns error when both remote and cache fail", () async {
        // Arrange
        final exception = Exception("Network error");
        when(
          mockLocalDataSource.getProfileData(),
        ).thenAnswer((_) async => null);
        when(mockRemoteDataSource.getProfileData()).thenAnswer(
          (_) async => Error<ProfileResponseModel>(exception: exception),
        );

        // Act
        final result = await repository.getProfileData();

        // Assert
        expect(result, isA<Error<ProfileDataEntity>>());
        result.when(
          success: (_) => fail('Expected error but got success'),
          error: (error) {
            expect(error, exception);
          },
        );

        verify(mockRemoteDataSource.getProfileData()).called(1);
        verify(mockLocalDataSource.getProfileData()).called(1);
        verifyNever(mockLocalDataSource.saveProfileData(any));
      });

      test("returns cached data when remote returns null", () async {
        // Arrange
        when(
          mockLocalDataSource.getProfileData(),
        ).thenAnswer((_) async => testEntity);
        when(mockRemoteDataSource.getProfileData()).thenAnswer(
          (_) async => const Success<ProfileResponseModel>(data: null),
        );

        // Act
        final result = await repository.getProfileData();

        // Assert
        expect(result, isA<Success<ProfileDataEntity>>());
        result.when(
          success: (data) {
            expect(data, testEntity);
          },
          error: (_) => fail('Expected success but got error'),
        );

        verify(mockRemoteDataSource.getProfileData()).called(1);
        verify(mockLocalDataSource.getProfileData()).called(1);
        verifyNever(mockLocalDataSource.saveProfileData(any));
      });

      test(
        "returns error when remote returns null and no cache available",
        () async {
          // Arrange
          when(
            mockLocalDataSource.getProfileData(),
          ).thenAnswer((_) async => null);
          when(mockRemoteDataSource.getProfileData()).thenAnswer(
            (_) async => const Success<ProfileResponseModel>(data: null),
          );

          // Act
          final result = await repository.getProfileData();

          // Assert
          expect(result, isA<Error<ProfileDataEntity>>());
          result.when(
            success: (_) => fail('Expected error but got success'),
            error: (error) {
              expect(error.toString(), contains('No profile data available'));
            },
          );

          verify(mockRemoteDataSource.getProfileData()).called(1);
          verify(mockLocalDataSource.getProfileData()).called(1);
          verifyNever(mockLocalDataSource.saveProfileData(any));
        },
      );
    });
  });
}
