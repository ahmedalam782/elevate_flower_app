// features/logout/api/datasources/logout_remote_data_source_impl.dart

import 'package:elevate_flower_app/features/logout/api/api_client/logout_api_client.dart'; // ✅
import 'package:elevate_flower_app/features/logout/data/datasources/logout_remote_data_source_contract.dart';
import 'package:elevate_flower_app/features/logout/data/models/logout_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRemoteDataSource)
class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource {
  final LogoutApiClient apiClient; 

  LogoutRemoteDataSourceImpl(this.apiClient); 

  @override
  Future<LogoutResponseModel> logout() async {
    return await apiClient.logout();
  }
}