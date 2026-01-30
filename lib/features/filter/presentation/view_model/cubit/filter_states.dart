// features/filter/presentation/view_model/cubit/filter_states.dart

import 'package:elevate_flower_app/features/categories/data/models/product_model/products_response_models.dart';
import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {
  final FilterType? currentFilter;
  
  FilterLoading({this.currentFilter});
}

class FilterLoaded extends FilterState {
  final ProductsResponseModels products;
  final FilterType? appliedFilter;

  FilterLoaded({
    required this.products,
    this.appliedFilter,
  });
}

class FilterError extends FilterState {
  final String message;
  final FilterType? attemptedFilter;

  FilterError({
    required this.message,
    this.attemptedFilter,
  });
}
