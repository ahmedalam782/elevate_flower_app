abstract class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationServiceDisabledException extends LocationException {
  const LocationServiceDisabledException()
    : super('Location service is disabled');
}

class PermissionNotGrantedException extends LocationException {
  const PermissionNotGrantedException()
    : super('Location permission not granted');
}

class PermissionPermanentlyDeniedException extends LocationException {
  const PermissionPermanentlyDeniedException()
    : super('Location permission permanently denied');
}

class LocationUnknownException extends LocationException {
  const LocationUnknownException(super.message);
}
