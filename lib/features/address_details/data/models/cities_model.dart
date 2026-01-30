// ignore_for_file: public_member_api_docs, sort_constructors_first
class CityModel {
  final String id;
  final String nameAr;
  final String nameEn;

  CityModel({required this.id, required this.nameAr, required this.nameEn});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      nameAr: json['governorate_name_ar'] as String,
      nameEn: json['governorate_name_en'] as String,
    );
  }

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nameAr == nameAr && other.nameEn == nameEn;
  }

  @override
  int get hashCode => id.hashCode ^ nameAr.hashCode ^ nameEn.hashCode;

  CityModel copyWith({String? id, String? nameAr, String? nameEn}) {
    return CityModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }
}
