import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_tab_bar.dart';
import '../../../domain/entities/category_entity.dart';
import '../../view_model/cubit/categories_cubit.dart';
import '../../view_model/cubit/categories_events.dart';
import '../../view_model/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabBuilder extends StatefulWidget {
  const CategoryTabBuilder({super.key, this.incomingIndex});
  final int? incomingIndex;
  @override
  State<CategoryTabBuilder> createState() => _CategoryTabBuilderState();
}

class _CategoryTabBuilderState extends State<CategoryTabBuilder> {
  int selectedCategoryIndex = 0;
  List<CategoryEntity> categories = [];
  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.incomingIndex ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        return state.category.when(
          initial: () => CustomTabBar(
            tabList: const [],
            onSelectedItem: (index) {},
            selectedIndex: selectedCategoryIndex,
            isInitialLoading: true,
          ),
          loading: () => CustomTabBar(
            tabList: const [],
            onSelectedItem: (index) {},
            selectedIndex: selectedCategoryIndex,
            isInitialLoading: true,
          ),
          success: (cats) {
            categories = cats;
            return _buildCategoryTabs(categories);
          },
          error: (exception) => SizedBox(
            height: 48,
            child: Center(
              child: Text(LocaleKeys.categories_error_loading_categories.tr()),
            ),
          ),
        );
      },
    );
  }

  //!<<<<<<<<<=============???????????
  Widget _buildCategoryTabs(List<CategoryEntity> categories) {
    final tabs = ['All', ...categories.map((c) => c.name)];

    return CustomTabBar(
      tabList: tabs,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onSelectedItem: (index) {
        setState(() {
          selectedCategoryIndex = index;
        });

        // Trigger products fetch for selected category
        if (index == 0) {
          // If "All" is selected, get all products
          context.read<CategoriesCubit>().onEvent(
            GetProductsEvent(categoryId: ''),
          );
        } else {
          // Get products for specific category
          final categoryId = categories[index - 1].id;
          context.read<CategoriesCubit>().onEvent(
            GetProductsEvent(categoryId: categoryId),
          );
        }
      },
      selectedIndex: selectedCategoryIndex,
      isInitialLoading: false,
    );
  }
}
