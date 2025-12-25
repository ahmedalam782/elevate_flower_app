import 'package:elevate_flower_app/core/config/api/end_points.dart';
import 'package:elevate_flower_app/features/register/api/datasources/register_local_data_source_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_local_data_source_impl_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late RegisterLocalDataSourceImpl dataSourceImpl;
  late MockFlutterSecureStorage secureStorageMock;
  setUp(() {
    secureStorageMock = MockFlutterSecureStorage();
    dataSourceImpl = RegisterLocalDataSourceImpl(secureStorageMock);
  });
  group("test local data source implementation", () {
    test("test saving token in secure storage", ()async {
      when(
        secureStorageMock.write(key: anyNamed("key"), value: anyNamed("value")),
      ).thenAnswer((_) => Future.value());
      await dataSourceImpl.saveAuthToken("token");
      verify(
        secureStorageMock.write(key: Apikeys.accessToken, value: "token"),
      ).called(1);
    });
  });
}
