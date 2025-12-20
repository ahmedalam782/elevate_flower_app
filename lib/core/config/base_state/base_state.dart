import 'package:equatable/equatable.dart';

enum StateType { initial, loading, moreLoading, success, error }

// changed from abstract class to class to make it possible to be initialized
class BaseState<T> extends Equatable {
  final StateType? state;
  final T? data;
  final Exception? exception;

  const BaseState({this.state = StateType.initial, this.data, this.exception});

  @override
  List<Object?> get props => [state, data, exception];

  const BaseState.initial()
    : state = StateType.initial,
      data = null,
      exception = null;

  const BaseState.loading()
    : state = StateType.loading,
      data = null,
      exception = null;

  const BaseState.success(this.data)
    : state = StateType.success,
      exception = null;

  const BaseState.error(this.exception) : state = StateType.error, data = null;
  const BaseState.all({
    required this.exception,
    required this.data,
    required this.state,
  });

  // added when method to make the code more readable in the UI
  R when<R>({
    required R Function(T data) success,
    required R Function() loading,
    R Function()? moreLoading,
    required R Function(Exception exception) error,
    required R Function() initial,
  }) {
    return switch (state ?? StateType.initial) {
      StateType.initial => initial(),
      StateType.loading => loading(),
      StateType.moreLoading => moreLoading != null ? moreLoading() : loading(),
      StateType.success => success(data as T),
      StateType.error => error(exception!),
    };
  }

  @override
  String toString() {
    return 'BaseState(state:$state,${data != null ? ',data: $data, ' : ''}${exception != null ? ',exception: $exception' : ''})';
  }
}
