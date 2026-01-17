import 'package:json_annotation/json_annotation.dart';
part 'occasions_model.g.dart';

@JsonSerializable()
class OccasionModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'occasions')
  List<Occasion>? occasions;

  OccasionModel({this.message, this.metadata, this.occasions});

  factory OccasionModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionModelFromJson(json);

  static List<OccasionModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(OccasionModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OccasionModelToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;
  @JsonKey(name: 'productsCount')
  int? productsCount;

  Occasion({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.productsCount,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);

  static List<Occasion> fromList(List<Map<String, dynamic>> list) {
    return list.map(Occasion.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'limit')
  int? limit;
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  Metadata({this.currentPage, this.limit, this.totalPages, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
