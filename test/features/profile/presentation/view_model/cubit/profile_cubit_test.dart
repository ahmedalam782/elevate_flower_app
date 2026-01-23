import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/profile/domain/entities/profile_data_entity.dart';
import 'package:elevate_flower_app/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:elevate_flower_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:elevate_flower_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileDataUseCase])
void main() {
  late ProfileCubit cubit;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;

  setUpAll(() {
    provideDummy<Result<ProfileDataEntity>>(
      Success<ProfileDataEntity>(
        data: ProfileDataEntity(
          id: "dummy_id",
          firstName: "Dummy",
          lastName: "User",
          email: "dummy@test.com",
          gender: "male",
          phone: "1234567890",
          photo: "https://example.com/photo.jpg",
          role: "user",
          wishlist: [],
          addresses: [],
          createdAt: "2024-01-01",
        ),
      ),
    );
  });

  setUp(() {
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    cubit = ProfileCubit(mockGetProfileDataUseCase);
  });

  group("ProfileCubit Tests", () {
    test("initial state is correct", () {
      expect(cubit.state.profileDataState.state, StateType.initial);
      expect(cubit.state.profileDataState.data, isNull);
    });

    group("loadProfileData", () {
      final testProfileData = ProfileDataEntity(
        id: "1",
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        gender: "male",
        phone: "1234567890",
        photo: "https://example.com/john.jpg",
        role: "user",
        wishlist: [],
        addresses: [],
        createdAt: "2024-01-15",
      );

      test(
        "emits loading then success on successful profile data fetch",
        () async {
          // Arrange
          when(mockGetProfileDataUseCase.call()).thenAnswer(
            (_) async => Success<ProfileDataEntity>(data: testProfileData),
          );

          // Act
          final states = cubit.stream
              .map((state) => state.profileDataState)
              .take(2)
              .toList();

          cubit.doIntent(ProfileEvents.loadProfileData());

          final result = await states;

          // Assert
          expect(result[0].state, StateType.loading);
          expect(result[1].state, StateType.success);
          expect(result[1].data, testProfileData);
          expect(result[1].data?.fullName, "John Doe");

          verify(mockGetProfileDataUseCase.call()).called(1);
        },
      );

      test("emits loading then error on failed profile data fetch", () async {
        // Arrange
        final exception = Exception("Failed to load profile data");
        when(mockGetProfileDataUseCase.call()).thenAnswer(
          (_) async => Error<ProfileDataEntity>(exception: exception),
        );

        // Act
        final states = cubit.stream
            .map((state) => state.profileDataState)
            .take(2)
            .toList();

        cubit.doIntent(ProfileEvents.loadProfileData());

        final result = await states;

        // Assert
        expect(result[0].state, StateType.loading);
        expect(result[1].state, StateType.error);
        expect(result[1].exception, exception);
        expect(result[1].data, isNull);

        verify(mockGetProfileDataUseCase.call()).called(1);
      });

      test("can reload profile data multiple times", () async {
        // Arrange
        final updatedProfileData = ProfileDataEntity(
          id: "1",
          firstName: "Jane",
          lastName: "Smith",
          email: "jane.smith@example.com",
          gender: "female",
          phone: "9876543210",
          photo: "https://example.com/jane.jpg",
          role: "user",
          wishlist: [],
          addresses: [],
          createdAt: "2024-01-20",
        );

        when(mockGetProfileDataUseCase.call()).thenAnswer(
          (_) async => Success<ProfileDataEntity>(data: testProfileData),
        );

        // First load
        cubit.doIntent(ProfileEvents.loadProfileData());
        await Future.delayed(const Duration(milliseconds: 100));

        // Update mock to return updated data
        when(mockGetProfileDataUseCase.call()).thenAnswer(
          (_) async => Success<ProfileDataEntity>(data: updatedProfileData),
        );

        // Second load
        cubit.doIntent(ProfileEvents.loadProfileData());
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(cubit.state.profileDataState.state, StateType.success);
        expect(cubit.state.profileDataState.data, updatedProfileData);
        expect(cubit.state.profileDataState.data?.fullName, "Jane Smith");

        verify(mockGetProfileDataUseCase.call()).called(2);
      });
    });

    test("ProfileDataEntity fullName getter works correctly", () {
      final profileData = ProfileDataEntity(
        id: "1",
        firstName: "Ahmed",
        lastName: "Mohamed",
        email: "ahmed@example.com",
        gender: "male",
        phone: "1234567890",
        photo: "https://example.com/ahmed.jpg",
        role: "user",
        wishlist: [],
        addresses: [],
        createdAt: "2024-01-01",
      );

      expect(profileData.fullName, "Ahmed Mohamed");
    });

    test("cubit can be closed successfully", () async {
      await cubit.close();
      expect(cubit.isClosed, true);
    });
  });
}
