import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/pages/categories_page.dart';
import 'package:elevate_flower_app/features/home/presentation/view/pages/home_page.dart';
import 'package:elevate_flower_app/features/main_layout/presentation/view/widgets/custom_nav_bar.dart';
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
  int _categoryIndex = 0;

  late final List<Widget> tabs;
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

  void _switchTab(int index) {
    setState(() => selectedIndex = index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: "Flowery"),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => selectedIndex = value),
        children: [
          HomePage(
            onSeeAllCategories: () {
              setState(() {
                _categoryIndex = 0;
              });
              _switchTab(1);
            },
            onSelectCategory: (index) {
              setState(() {
                if (index != null) {
                  _categoryIndex = index + 1;
                } else {
                  _categoryIndex = 0;
                }
              });

              _switchTab(1);
            },
          ),
          CategoriesPage(incomingIndex: _categoryIndex),
          const Center(child: Text("Cart")),
          const Center(child: Text("Profile")),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: selectedIndex,
        onTap: _switchTab,
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
