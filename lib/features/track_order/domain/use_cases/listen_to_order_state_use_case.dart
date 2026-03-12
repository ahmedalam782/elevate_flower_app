import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListenToOrderStateUseCase {
  final TrackOrderRepository repo;

  ListenToOrderStateUseCase({required this.repo});
  Stream<Result<String?>> call({required String orderId}) =>
      repo.listenToOrderState(orderId: orderId);
}
