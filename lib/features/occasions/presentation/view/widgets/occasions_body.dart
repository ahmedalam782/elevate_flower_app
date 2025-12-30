import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionsBody extends StatefulWidget {
  const OccasionsBody({super.key});

  @override
  State<OccasionsBody> createState() => _OccasionsBodyState();
}

class _OccasionsBodyState extends State<OccasionsBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OccasionsCubit, OccasionsStates>(
          builder: (context, state) => CustomTabBar(
            tabList: const ["test1", "test2", "test3"],
            onSelectedItem: (int index) {},
            selectedIndex: 1,
          ),
        ),
        const PaginatedProductGridView(products: []),
      ],
    );
  }
}
