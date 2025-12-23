import 'package:elevate_flower_app/core/theme/app_colors.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItem extends BottomNavigationBarItem {
  NavBarItem({required super.label, required String icon})
    : super(
        icon: SvgPicture.asset(
          icon,
        ),
        activeIcon: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          icon,
          colorFilter: ColorFilter.mode(AppColors.primerColor, BlendMode.srcIn),
        ),
      );
}
