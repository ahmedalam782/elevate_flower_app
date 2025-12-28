import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/shared/widgets/custom_search_with_filter.dart';
import '../../../../../core/shared/widgets/product_grid_example_page.dart';
import '../../../../../core/shared/widgets/search_with_filter_example_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isInitialLoading = true;
  int selectedIndex = 0;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isInitialLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchWithFilterExamplePage();
    // return Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         CustomSearchWithFilter(
    //           onSearchChanged: (value) {},
    //           onFilterTap: () {

    //           },
    //         ),
    //         CustomTabBar(
    //           isInitialLoading: isInitialLoading,
    //           tabList: ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4', 'Tab 5'],
    //           onSelectedItem: (index) {
    //             setState(() {
    //               selectedIndex = index;
    //             });
    //           },
    //           selectedIndex: selectedIndex,
    //         ),
    //         Expanded(child: ProductGridExamplePage()),
    //       ],
    //     ),
    //   ),
    // );
  }
}
