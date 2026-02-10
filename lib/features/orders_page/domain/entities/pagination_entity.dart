// في ملف pagination_entity.dart
import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;

  const PaginationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  // ✅ أضيفي الـ factory method ده
  factory PaginationEntity.fromJson(Map<String, dynamic> json) {
    return PaginationEntity(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      limit: json['limit'] as int,
      totalItems: json['totalItems'] as int,
    );
  }

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;
  bool get isFirstPage => currentPage == 1;
  bool get isLastPage => currentPage == totalPages;

  @override
  List<Object?> get props => [currentPage, totalPages, limit, totalItems];
}