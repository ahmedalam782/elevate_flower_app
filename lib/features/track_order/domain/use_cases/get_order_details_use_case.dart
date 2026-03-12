import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:elevate_flower_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOrderDetailsUseCase {
  final TrackOrderRepository repo;

  GetOrderDetailsUseCase({required this.repo});
  Future<Result<TrackOrderEntity>> call({required String orderId}) async =>
      repo.getOrderDetails(orderId: orderId);
}
