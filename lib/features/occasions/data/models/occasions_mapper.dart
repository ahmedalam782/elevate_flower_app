import 'occasions_model.dart';
import '../../domain/entities/occasion_card_entity.dart';

extension OccasionsMapper on Occasion {
  OccasionCardEntity toEntity() {
    return OccasionCardEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
      productsCount: productsCount ?? 0,
    );
  }
}
