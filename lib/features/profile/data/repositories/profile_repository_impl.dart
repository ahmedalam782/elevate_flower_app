import 'package:injectable/injectable.dart';
import '../../../../core/config/base_response/result.dart';
import '../../domain/entities/profile_data_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source_contract.dart';
import '../datasources/profile_remote_data_source_contract.dart';
import '../models/profile_model_mapper.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSourceContract _remoteDataSource;
  final ProfileLocalDataSourceContract _localDataSource;

  ProfileRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<ProfileDataEntity>> getProfileData() async {
    // Try to get cached data first
    final cachedData = await _localDataSource.getProfileData();

    // Fetch from remote
    final result = await _remoteDataSource.getProfileData();

    return result.when(
      success: (data) async {
        if (data != null) {
          // Convert model to entity
          final entity = data.toEntity();

          // Cache the profile data
          await _localDataSource.saveProfileData(entity);

          return Success<ProfileDataEntity>(data: entity);
        } else {
          // If remote data is null, return cached data if available
          if (cachedData != null) {
            return Success<ProfileDataEntity>(data: cachedData);
          }
          return Error<ProfileDataEntity>(
            exception: Exception('No profile data available'),
          );
        }
      },
      error: (exception) {
        // On error, try to return cached data
        if (cachedData != null) {
          return Success<ProfileDataEntity>(data: cachedData);
        }
        return Error<ProfileDataEntity>(exception: exception);
      },
    );
  }
}
