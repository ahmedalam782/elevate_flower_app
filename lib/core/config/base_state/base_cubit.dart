import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T, E, N> extends Cubit<T> {
  BaseCubit(super.initialState);

  Future<void> doAction(E event);

  final StreamController<N> _streamController = StreamController.broadcast();

  Stream<N> get navigationStream => _streamController.stream;

  void doNavigationAction(N navigationAction) {
    _streamController.add(navigationAction);
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
