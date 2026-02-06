import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/routes/routes.dart';
import 'Categories_builder.dart';
import 'bestseller_builder.dart';
import 'header_section.dart';
import 'occasion_widget.dart';
import 'section_titile_and_view_all.dart';
import '../../view_model/cubit/home_cubit.dart';
import '../../view_model/cubit/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, this.onSeeAllCategories, this.onSelectedCategory});
  final VoidCallback? onSeeAllCategories;
  final Function(int?)? onSelectedCategory;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
        child: Column(
          children: [
            const HeaderSection(),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),

                      // Categories Section
                      SectionTitileAndViewAll(
                        onTap: widget.onSeeAllCategories,
                        title: LocaleKeys.home_screen_categories_title.tr(),
                      ),
                      CategoriesBuilder(
                        onSelectedCategory: widget.onSelectedCategory,
                      ),
                      const SizedBox(height: 20),

                      // Best Seller Section
                      SectionTitileAndViewAll(
                        onTap: () {
                          context.push(Routes.bestSellers);
                        },
                        title: LocaleKeys.home_screen_best_seller_title.tr(),
                      ),
                      const BestsellerBuilder(),
                      const SizedBox(height: 0),

                      // Occasion Section
                      SectionTitileAndViewAll(
                        onTap: () {
                          context.push(Routes.occasions);
                        },
                        title: LocaleKeys.home_screen_occasion_title.tr(),
                      ),
                      const OccasionWidget(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
