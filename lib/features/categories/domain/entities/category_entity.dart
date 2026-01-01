class CategoryEntity {
  final String id;
  final String name;
  final String slug;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSuperAdmin;
  final int productsCount;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount,
  });
}