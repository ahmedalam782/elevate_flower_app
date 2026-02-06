import '../../../../core/config/api/end_points.dart';
import '../../data/datasources/register_local_data_source_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RegisterLocalDataSourceContract)
class RegisterLocalDataSourceImpl implements RegisterLocalDataSourceContract {
  FlutterSecureStorage secureStorage;
  RegisterLocalDataSourceImpl(this.secureStorage);
  @override
  Future<void> saveAuthToken(String token) {
    return secureStorage.write(key: Apikeys.accessToken, value: token);
  }
}
