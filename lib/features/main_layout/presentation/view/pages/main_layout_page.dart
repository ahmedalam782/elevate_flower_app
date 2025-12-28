import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/features/main_layout/presentation/view/widgets/custom_nav_bar.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view/pages/occasions_page.dart';

import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayoutPage> {
  late PageController _pageController;
  int selectedIndex = 0;
  final List<Widget> tabs =  [
    OccasionsPage(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(title: "Flowery"),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => selectedIndex = value),
        children: tabs,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          _pageController.animateToPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            value,
          );
        },
        items: [
          NavBarItem(
            icon: AppIcons.iconsHome,
            label: LocaleKeys.bottom_navigation_home.tr(),
          ),
          NavBarItem(
            icon: AppIcons.iconsCategory,
            label: LocaleKeys.bottom_navigation_categories.tr(),
          ),
          NavBarItem(
            icon: AppIcons.iconsCart,
            label: LocaleKeys.bottom_navigation_cart.tr(),
          ),
          NavBarItem(
            icon: AppIcons.iconsProfile,
            label: LocaleKeys.bottom_navigation_profile.tr(),
          ),
        ],
      ),
    );
  }
}
