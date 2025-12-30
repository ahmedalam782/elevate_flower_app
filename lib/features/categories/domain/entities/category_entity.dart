/// Domain Entity for Category
/// This represents the business model, independent of data sources
class CategoryEntity {
  final String id;
  final String name;
  final String slug;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSuperAdmin;
  final int productsCount; // 👈 أضف ده

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount, // 👈 وده
  });

  /// Copy with method for immutability
  CategoryEntity copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSuperAdmin,
    int? productsCount, // 👈 وده
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      productsCount: productsCount ?? this.productsCount, // 👈 وده
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryEntity &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isSuperAdmin == isSuperAdmin &&
        other.productsCount == productsCount; // 👈 وده
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isSuperAdmin.hashCode ^
        productsCount.hashCode; // 👈 وده
  }

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, slug: $slug, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, isSuperAdmin: $isSuperAdmin, productsCount: $productsCount)'; // 👈 وده
  }
}