import 'package:elevate_flower_app/core/shared/widgets/filter_bottom_sheet.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/category_tab_builder.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/filter_bottom.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/product_card_builder.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/search_bar_with_filtter.dart';
import 'package:flutter/material.dart';

class CategoriesBody extends StatefulWidget {
  const CategoriesBody({super.key});

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  SortOption? selectedSort;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              SearchBarWithFiltter(),

              CategoryTabBuilder(),
              SizedBox(height: 10),

              ProductCardBuilder(),
            ],
          ),
          FilterBottom(),
        ],
      ),
    );
  }
}
