import '../../../../core/config/base_response/result.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartDataUseCase {
  final CartRepository repo;

  GetCartDataUseCase({required this.repo});

  Future<Result<CartEntity>> call() => repo.getCartData();
}
