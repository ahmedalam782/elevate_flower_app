import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionsBody extends StatefulWidget {
  const OccasionsBody({super.key});

  @override
  State<OccasionsBody> createState() => _OccasionsBodyState();
}

class _OccasionsBodyState extends State<OccasionsBody> {
  late OccasionsCubit _cubit;
  int _selectedIndex = 0;
  @override
  void initState() {
    _cubit = context.read<OccasionsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OccasionsCubit, OccasionsStates>(
          buildWhen: (previous, current) =>
              previous.occasions != current.occasions,
          builder: (context, state) {
            return CustomTabBar(
              isInitialLoading: state.occasions.state == StateType.loading,
              itemsPerPage: state.occasions.data?.length ?? 0,
              tabList:
                  state.occasions.data
                      ?.map((occasion) => occasion.name)
                      .toList() ??
                  [],
              onSelectedItem: (int index) async {
                if (index == _selectedIndex) return;
                setState(() {
                  _selectedIndex = index;
                });
                final selectedOccasionId =
                    state.occasions.data?[index].id ?? '';
                _cubit.doIntent(
                  OccasionsEvents.changeSelectedOccasion(selectedOccasionId),
                );
              },
              selectedIndex: _selectedIndex,
            );
          },
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.80,
          child: BlocBuilder<OccasionsCubit, OccasionsStates>(
            buildWhen: (previous, current) =>
                previous.productsByOccasion != current.productsByOccasion,
            builder: (context, state) {
              return PaginatedProductGridView(
                key: ValueKey(_selectedIndex),
                isLoading: state.productsByOccasion.state == StateType.loading,
                products: state.productsByOccasion.data ?? [],
              );
            },
          ),
        ),
      ],
    );
  }
}
