// features/filter/presentation/view_model/cubit/filter_cubit.dart

import 'package:elevate_flower_app/features/filter/domain/entities/filter_type.dart';
import 'package:elevate_flower_app/features/filter/domain/use_cases/get_filtered_products.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterCubit extends Cubit<FilterState> {
  final GetFilteredProducts getFilteredProducts;

  FilterCubit({required this.getFilteredProducts}) : super(FilterInitial());

  FilterType? _currentFilterType;

  FilterType? get currentFilterType => _currentFilterType;

  /// تحميل كل المنتجات بدون فلتر
  Future<void> loadProducts() async {
    _currentFilterType = null;

    emit(FilterLoading());

    try {
      final products = await getFilteredProducts(null);
      
      emit(FilterLoaded(products: products));
    } catch (e) {
      emit(FilterError(message: e.toString()));
    }
  }

  /// تطبيق فلتر معين
  Future<void> applyFilter(FilterType filterType) async {
    _currentFilterType = filterType;

    emit(FilterLoading(currentFilter: filterType));

    try {
      final products = await getFilteredProducts(filterType);
      
      emit(FilterLoaded(
        products: products,
        appliedFilter: filterType,
      ));
    } catch (e) {
      emit(FilterError(
        message: e.toString(),
        attemptedFilter: filterType,
      ));
    }
  }

  /// إزالة الفلتر
  Future<void> clearFilter() async {
    await loadProducts();
  }
}