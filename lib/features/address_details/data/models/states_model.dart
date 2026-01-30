// ignore_for_file: public_member_api_docs, sort_constructors_first
class StatesModel {
  final String? id;
  final String? governorateId;
  final String? nameAr;
  final String? nameEn;

  StatesModel({this.id, this.governorateId, this.nameAr, this.nameEn});

  factory StatesModel.fromJson(Map<String, dynamic> json) {
    return StatesModel(
      id: json['id'],
      governorateId: json['governorate_id'],
      nameAr: json['city_name_ar'],
      nameEn: json['city_name_en'],
    );
  }

  @override
  bool operator ==(covariant StatesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.governorateId == governorateId &&
        other.nameAr == nameAr &&
        other.nameEn == nameEn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        governorateId.hashCode ^
        nameAr.hashCode ^
        nameEn.hashCode;
  }

  StatesModel copyWith({
    String? id,
    String? governorateId,
    String? nameAr,
    String? nameEn,
  }) {
    return StatesModel(
      id: id ?? this.id,
      governorateId: governorateId ?? this.governorateId,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }
}
