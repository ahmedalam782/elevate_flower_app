class CategoryEntity {
  final String id;
  final String name;
  final String? slug;
  final String ?image;
  final DateTime? createdAt;
  final DateTime ?updatedAt;
  final bool ?isSuperAdmin;
  final int? productsCount;

  CategoryEntity({
    required this.id,
    required this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.productsCount,
  });
}