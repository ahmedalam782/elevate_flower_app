sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T? data) success,
    required R Function(Exception? exception) error,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Error<T>) {
      return error((this as Error<T>).exception);
    } else {
      return error(Exception("Unhandled ApiResult case"));
    }
  }
}

class Success<T> extends Result<T> {
  final T? data;
  const Success({this.data});
}

class Error<T> extends Result<T> {
  final Exception? exception;
  const Error({this.exception});
}
