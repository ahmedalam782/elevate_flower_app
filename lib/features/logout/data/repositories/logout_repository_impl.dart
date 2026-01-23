import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/logout/data/datasources/logout_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';
import 'package:elevate_flower_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSource remoteDataSource;
  //final TokenManager tokenManager;

  LogoutRepositoryImpl(
    this.remoteDataSource,
    //this.tokenManager,
  );

  @override
  Future<Result<LogoutResponseModel>> logout() async {
    try {
     // log('🔄 Starting logout process...');
      
      // Print current token status before logout
     // await tokenManager.printTokenStatus();
      
      // Call API
      final response = await remoteDataSource.logout();
     // log('✅ Logout API call successful');
      
      // Clear all tokens
     // await tokenManager.clearAllTokens();
      
      // Verify tokens are cleared
      // final isStillAuthenticated = await tokenManager.isAuthenticated();
      // if (isStillAuthenticated) {
      //   log('⚠️ WARNING: User still appears authenticated after logout!');
      // } else {
      //   log('✅ User successfully logged out - tokens cleared');
      // }
      
      return Success(data: response);
    } on DioException catch (e) {
      log('❌ Logout failed - DioException: ${e.message}');
      
      final errorMessage = e.response?.data is Map<String, dynamic>
          ? (e.response!.data['message'] as String?)
          : null;
      
      return Error(
        exception: Exception(
          errorMessage ?? 'Logout failed. Please try again.',
        ),
      );
    } catch (e) {
      log('❌ Logout failed - Exception: ${e.toString()}');
      
      return Error(
        exception: Exception('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}