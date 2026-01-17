import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/failures.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_tab_bar.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/core/shared/widgets/error_page.dart';
import 'package:elevate_flower_app/core/shared/widgets/paginated_product_grid_view.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class OccasionsBody extends StatefulWidget {
  const OccasionsBody({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<OccasionsBody> createState() => _OccasionsBodyState();
}

class _OccasionsBodyState extends State<OccasionsBody> {
  late OccasionsCubit _cubit;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _cubit = context.read<OccasionsCubit>();
    _selectedTabIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionsCubit, OccasionsStates>(
      listener: (BuildContext context, OccasionsStates state) {
        // Handle occasions error
        if (state.occasions.state == StateType.error) {
          final error = state.occasions.exception;
          if (error is Failures) {
            CustomToast(
              context: context,
              header: error.errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        }
        // Handle products error
        if (state.productsByOccasion.state == StateType.error) {
          final error = state.productsByOccasion.exception;
          if (error is Failures) {
            CustomToast(
              context: context,
              header: error.errorMessage,
              type: ToastificationType.error,
            ).showToast();
          }
        }
      },
      builder: (context, state) {
        if (state.occasions.state == StateType.error) {
          return ErrorPage(
            isConnectionerror: true,
            onRefresh: () async =>
                _cubit.doIntent(OccasionsEvents.getOccasions()),
          );
        }
        return Column(
          children: [
            CustomTabBar(
              isInitialLoading: state.occasions.state == StateType.loading,
              itemsPerPage: state.occasions.data?.length ?? 0,
              tabList:
                  state.occasions.data
                      ?.map((occasion) => occasion.name)
                      .toList() ??
                  [],
              onSelectedItem: (int index) async {
                if (index == _selectedTabIndex) return;
                setState(() {
                  _selectedTabIndex = index;
                });
                final selectedOccasionId =
                    state.occasions.data?[index].id ?? '';
                _cubit.doIntent(
                  OccasionsEvents.changeSelectedOccasion(selectedOccasionId),
                );
              },
              selectedIndex: _selectedTabIndex,
            ),
            Expanded(
              child: PaginatedProductGridView(
                onProductTap: (product) {
                  context.push(Routes.productDetails, extra: product.id);
                },
                key: ValueKey(_selectedTabIndex),
                isLoading:
                    state.productsByOccasion.state == StateType.loading ||
                    state.occasions.state == StateType.loading,
                products: state.productsByOccasion.data ?? [],
              ),
            ),
          ],
        );
      },
    );
  }
}
