import 'package:elevate_flower_app/features/home/presentation/view/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onSelectCategory, this.onSeeAllCategories});
  final VoidCallback? onSeeAllCategories;
  final Function(int?)? onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(
        onSeeAllCategories: onSeeAllCategories,
        onSelectedCategory: onSelectCategory,
      ),
    );
  }
}
