import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/cart/domain/entities/cart_entity.dart';
import 'package:elevate_flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveProductFromCartUseCase {
  final CartRepository repo;

  RemoveProductFromCartUseCase({required this.repo});

  Future<Result<void>> call(String id) => repo.removeProductFromCart(id);
}
