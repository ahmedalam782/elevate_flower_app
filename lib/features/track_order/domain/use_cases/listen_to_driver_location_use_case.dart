import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListenToDriverLocationUseCase {
  final TrackOrderRepository repo;

  ListenToDriverLocationUseCase({required this.repo});
  Stream<Result<DriverLocationEntity>> call({required String orderId}) =>
      repo.listenToDriverLocation(orderId: orderId);
}
