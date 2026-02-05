import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import 'best_seller_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerBody extends StatelessWidget {
  const BestSellerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
          child: Text(
            LocaleKeys.best_seller_caption.tr(),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.gray53),
          ),
        ),
        const SizedBox(height: 10),
        const Expanded(child: BestSellerBlocBuilder()),
      ],
    );
  }
}
