import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/shared/widgets/custom_search_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarWithFiltter extends StatelessWidget {
  const SearchBarWithFiltter({super.key, this.onFilterTap});
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomSearchWithFilter(
        focusNode: focusNode,
        hintText: LocaleKeys.custom_widgets_search.tr(),
        labelText: LocaleKeys.custom_widgets_search.tr(),
        onTap: () {
          focusNode.unfocus();
          context.push(Routes.search);
        },

        onFilterTap: onFilterTap,
      ),
    );
  }
}
