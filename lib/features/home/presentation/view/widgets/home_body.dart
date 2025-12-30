import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/Categories_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/bestseller_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view/widgets/occasion_widget.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:elevate_flower_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:flutter/cupertino.dart';
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
    return Container(color: Colors.blueAccent);
  }
}










// BlocProvider(
//       create: (_) => getIt<HomeCubit>()
//         ..doAction(GetAllDataEvent()),
//       child: const SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CategoriesWidget(),
//             SizedBox(height: 16),
//             BestSellerWidget(),
//             SizedBox(height: 16),
//             OccasionWidget(),
//           ],
//         ),
//       ),
//     );