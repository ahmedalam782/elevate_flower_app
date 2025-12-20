import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../errors/failures.dart';
import '../../languages/locale_keys.g.dart';
import '../base_response/result.dart';
import '../di/injectable_config.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  if (!await getIt.get<InternetConnection>().hasInternetAccess) {
    return Error(
      exception: NetworkFailures(
        errorMessage: LocaleKeys.global_no_internet.tr(),
      ),
    );
  }
  try {
    var result = await apiCall();
    return Success<T>(data: result);
  } on DioException catch (ex) {
    return Error<T>(
      exception: ServerFailure.fromDioException(dioException: ex),
    );
  } on Exception catch (ex) {
    return Error<T>(exception: ex);
  }
}
