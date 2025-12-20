import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../languages/locale_keys.g.dart';

sealed class Failures implements Exception {
  final String errorMessage;

  const Failures({required this.errorMessage});
}

class ServerFailure extends Failures {
  const ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_connectionTimeout.tr(),
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_sendTimeout.tr(),
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_receiveTimeout.tr(),
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_badCertificate.tr(),
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioException.response!.statusCode,
          response: dioException.response!.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_cancelled.tr(),
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_connectionError.tr(),
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: LocaleKeys.error_api_failure_unknown.tr(),
        );
    }
  }

  factory ServerFailure.fromResponse({int? statusCode, dynamic response}) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 422 ||
        statusCode == 409 ||
        statusCode == 424 ||
        statusCode == 404) {
      return ServerFailure(
        errorMessage:
            response['message'] ?? LocaleKeys.error_api_failure_unknown.tr(),
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMessage: LocaleKeys.error_api_failure_server_error.tr(),
      );
    } else if (statusCode == 403) {
      //    Helper.expiredToken();

      // return the server failure instead of throw it
      return ServerFailure(
        errorMessage: LocaleKeys.error_api_failure_expiredToken.tr(),
      );
    } else {
      return ServerFailure(
        errorMessage: LocaleKeys.error_api_failure_unknown.tr(),
      );
    }
  }
}

class OfflineFailures extends Failures {
  const OfflineFailures({required super.errorMessage});
}

class CacheFailures extends Failures {
  const CacheFailures({required super.errorMessage});
}

class NetworkFailures extends Failures {
  const NetworkFailures({required super.errorMessage});
}

List<String> connectionErrorsList = [
  LocaleKeys.error_api_failure_connectionError.tr(),
  LocaleKeys.error_api_failure_connectionTimeout.tr(),
  LocaleKeys.error_api_failure_receiveTimeout.tr(),
  LocaleKeys.error_api_failure_sendTimeout.tr(),
];
