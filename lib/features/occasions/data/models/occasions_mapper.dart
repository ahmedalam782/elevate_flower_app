import 'package:elevate_flower_app/features/occasions/data/models/occasions_model.dart';
import 'package:elevate_flower_app/features/occasions/domain/entities/occasion_card_entity.dart';

extension OccasionsMapper on Occasion {
  OccasionCardEntity toEntity() {
    return OccasionCardEntity(
      id: id,
      name: name,
      image: image,
      productsCount: productsCount,
    );
  }
}
