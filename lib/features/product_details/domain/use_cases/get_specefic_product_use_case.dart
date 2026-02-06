import '../../../../core/config/base_response/result.dart';
import '../entities/specefic_product_entity.dart';
import '../repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSpeceficProductUseCase {
  final ProductDetailsRepository productDetailsRepository;

  GetSpeceficProductUseCase({required this.productDetailsRepository});

  Future<Result<SpeceficProductEntity>> call(String id) =>
      productDetailsRepository.getSpeceficProduct(id);
}
