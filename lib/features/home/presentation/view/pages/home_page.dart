import '../widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onSelectCategory, this.onSeeAllCategories});
  final VoidCallback? onSeeAllCategories;
  final Function(int?)? onSelectCategory;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: HomeBody(
        onSeeAllCategories: widget.onSeeAllCategories,
        onSelectedCategory: widget.onSelectCategory,
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
