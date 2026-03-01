import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.search);
      },
      child: AbsorbPointer(
        child: SizedBox(
          height: height,
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: LocaleKeys.custom_widgets_search.tr(),
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Icon(Icons.search, color: Colors.grey[400], size: 24),
              ),
              filled: true,
              fillColor: AppColors.whiteFA,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.primerColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
