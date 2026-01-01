import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:elevate_flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabBuilder extends StatefulWidget {
  const CategoryTabBuilder({super.key});

  @override
  State<CategoryTabBuilder> createState() => _CategoryTabBuilderState();
}

class _CategoryTabBuilderState extends State<CategoryTabBuilder> {
  int selectedCategoryIndex = 0;
  List<CategoryEntity> categories = [];

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
    final tabs = ['All', ...categories.map((c) => c.name).toList()];

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
