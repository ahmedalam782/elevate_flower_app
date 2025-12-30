import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/theme/app_images.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/Categories_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/bestseller_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/occasion_widget.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
          child: Column(
            children: [
              // ================= Header =================
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // -------- Logo + Search --------
                    // Row(
                    //   children: [
                    //     Image.asset(
                    //       AppImages.imagesIcLauncherAndroid,
                    //       width: 30,
                    //       height: 30,
                    //     ),
                    //     const SizedBox(width: 8),
                    //     const Text(
                    //       'Flowery',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.normal,
                    //         color: Colors.pink,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 16),
                    
                    //     // Search Field (Corrected)
                    //     Expanded(
                    //       flex: 80,
                    //       child: SizedBox(
                    //         height: 48,
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //             hintText: 'Search',
                    //             hintStyle: const TextStyle(
                    //               color: Color(0xFFBDBDBD),
                    //               fontSize: 14,
                    //             ),
                    //             prefixIcon: const Icon(
                    //               Icons.search,
                    //               color: Color(0xFFBDBDBD),
                    //               size: 22,
                    //             ),
                    //             filled: true,
                    //             fillColor: Colors.white,
                    //             contentPadding: const EdgeInsets.symmetric(
                    //               vertical: 14,
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(30),
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFE0E0E0),
                    //                 width: 1,
                    //               ),
                    //             ),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(30),
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFE0E0E0),
                    //                 width: 1,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 12),

                    // -------- Delivery Location --------
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Deliver to 2XVP+XC - Sheikh Zayed',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: Colors.pink[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ================= Body =================
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // -------- Categories --------
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
                        const CategoriesWidget(),
                        const SizedBox(height: 20),

                        // -------- Best Seller --------
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
                        const BestSellerWidget(),
                        const SizedBox(height: 20),

                        // -------- Occasion --------
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
      ),
    );
  }
}

// import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
// import 'package:elevate_flower_app/core/theme/app_images.dart';
// import 'package:elevate_flower_app/features/home/presentation/view/widgets/Categories_widget.dart';
// import 'package:elevate_flower_app/features/home/presentation/view/widgets/bestseller_widget.dart';
// import 'package:elevate_flower_app/features/home/presentation/view/widgets/occasion_widget.dart';
// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
// import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_events.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeBody extends StatefulWidget {
//   const HomeBody({super.key});

//   @override
//   State<HomeBody> createState() => _HomeBodyState();
// }

// class _HomeBodyState extends State<HomeBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BlocProvider(
//           create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
//           child: Column(
//             children: [
//               // Header Section
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     // Logo and Search
//                     Row(
//                       children: [
//                         // Logo
//                         Image.asset(
//                           AppImages.imagesIcLauncherAndroid,
//                           width: 30,
//                           height: 30,
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Flowery',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.pink,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         // Search Field
//                         Expanded(
//                           child: Container(
//                             height: 45,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(color: Colors.grey[400]),
//                                 prefixIcon: Icon(
//                                   Icons.search,
//                                   color: Colors.grey[400],
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 50,
//                                   vertical: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     // Delivery Location
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.location_on_outlined,
//                           size: 18,
//                           color: Colors.black87,
//                         ),
//                         const SizedBox(width: 4),
//                         const Text(
//                           'Deliver to 2XVP+XC - Sheikh Zayed',
//                           style: TextStyle(fontSize: 12, color: Colors.black87),
//                         ),
//                         const SizedBox(width: 4),
//                         Icon(
//                           Icons.keyboard_arrow_down,
//                           size: 24,
//                           color: Colors.pink[300],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // Scrollable Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 8),

//                         // Categories Section
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Categories',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 'View All',
//                                 style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const CategoriesWidget(),
//                         const SizedBox(height: 20),

//                         // Best Seller Section
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Best seller',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 'View All',
//                                 style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const BestSellerWidget(),
//                         const SizedBox(height: 20),

//                         // Occasion Section
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Occasion',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 'View All',
//                                 style: TextStyle(
//                                   color: Colors.pink,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const OccasionWidget(),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
