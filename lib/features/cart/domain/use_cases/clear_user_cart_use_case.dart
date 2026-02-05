import '../../../../core/config/base_response/result.dart';
import '../repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearUserCartUseCase {
  final CartRepository repo;

  ClearUserCartUseCase({required this.repo});

  Future<Result<void>> call() => repo.clearUserCart();
}
