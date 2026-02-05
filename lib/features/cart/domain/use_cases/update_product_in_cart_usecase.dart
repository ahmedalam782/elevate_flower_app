import '../../../../core/config/base_response/result.dart';
import '../../data/models/post/cart_update_data.dart';
import '../repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductInCartUsecase {
  final CartRepository repo;

  UpdateProductInCartUsecase({required this.repo});

  Future<Result<void>> call(String id, CartUpdateDataModel data) =>
      repo.updateCartQuantity(id, data);
}
