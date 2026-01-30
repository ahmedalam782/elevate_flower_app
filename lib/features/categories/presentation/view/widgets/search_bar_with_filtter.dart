import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_search_with_filter.dart';
import 'package:elevate_flower_app/core/shared/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarWithFiltter extends StatefulWidget {
  const SearchBarWithFiltter({super.key});

  @override
  State<SearchBarWithFiltter> createState() => _SearchBarWithFiltterState();
}

class _SearchBarWithFiltterState extends State<SearchBarWithFiltter> {
  SortOption? selectedSort;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomSearchWithFilter(
        hintText: LocaleKeys.custom_widgets_search.tr(),
        labelText: LocaleKeys.custom_widgets_search.tr(),
        readOnly: true,
        onTap: () {
          context.push(Routes.search);
        },
        onFilterTap: () {
          showFilterBottomSheet(
            context: context,
            selectedSort: selectedSort,
            onApplyFilter: (sort) {
              setState(() {
                selectedSort = sort;
              });
            },
          );
        },
      ),
    );
  }
}
