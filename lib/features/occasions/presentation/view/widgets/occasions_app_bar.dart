import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OccasionsAppBar extends StatelessWidget {
  const OccasionsAppBar({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
        left: 14,
        right: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: 20.medium.copyWith(height: 1.2)),
              const SizedBox(height: 4),
              Text(
                subTitle,
                style: 13.regular.copyWith(
                  color: AppColors.gray53,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
