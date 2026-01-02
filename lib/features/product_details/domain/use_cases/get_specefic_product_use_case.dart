import 'package:elevate_flower_app/core/config/base_response/result.dart';
import 'package:elevate_flower_app/features/product_details/domain/entities/specefic_product_entity.dart';
import 'package:elevate_flower_app/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSpeceficProductUseCase {
  final ProductDetailsRepository productDetailsRepository;

  GetSpeceficProductUseCase({required this.productDetailsRepository});

  Future<Result<SpeceficProductEntity>> call(String id) =>
      productDetailsRepository.getSpeceficProduct(id);
}
