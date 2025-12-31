import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/Categories_builder.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/bestseller_builder.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/occasion_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/search_text_field.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: BlocProvider(
          create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Logo and Search
                    Row(
                      children: [
                        // Logo
                        Image.asset(
                          AppImages.imagesIcLauncherAndroid,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Flowery',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Search Field
                        Expanded(
                          child: SearchTextField()
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Delivery Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Deliver to 2XVP+XC - Sheikh Zayed',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                          color: Colors.pink[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CategoriesBuilder(),
                        const SizedBox(height: 20),

                        // Best Seller Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Best seller',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const BestsellerBuilder(),
                        const SizedBox(height: 0),

                        // Occasion Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Occasion',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
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
