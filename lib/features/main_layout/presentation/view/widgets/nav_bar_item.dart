import '../../../../../core/theme/app_colors.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItem extends BottomNavigationBarItem {
  NavBarItem({required super.label, required String icon})
    : super(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(AppColors.gray7D, BlendMode.srcIn),
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SvgPicture.asset(
            fit: BoxFit.scaleDown,
            icon,
            colorFilter: const ColorFilter.mode(
              AppColors.primerColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      );
}
