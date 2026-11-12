import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';
import '../../view_model/cubit/occasions_cubit.dart';
import '../../view_model/cubit/occasions_events.dart';
import '../../view_model/cubit/occasions_states.dart';
import '../widgets/occasions_app_bar.dart';
import '../widgets/occasions_body.dart';

class OccasionsPage extends StatefulWidget {
  const OccasionsPage({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<OccasionsPage> createState() => _OccasionsPageState();
}

class _OccasionsPageState extends State<OccasionsPage> {
  late final OccasionsCubit _viewModel;

  @override
  void initState() {
    super.initState();
    // Load once when the page is first created. Doing this inside build()
    // re-triggered the request every time the page was rebuilt (e.g. when
    // returning from the product details page), which caused a second
    // loading state behind an already loaded list.
    _viewModel = getIt<OccasionsCubit>()
      ..doIntent(OccasionsEvents.getOccasions(widget.selectedIndex ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocProvider.value(
        value: getIt<CartCubit>(),
        child: BlocBuilder<OccasionsCubit, OccasionsStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.whiteF9,
              body: Column(
                children: [
                  OccasionsAppBar(
                    title: LocaleKeys.occasion_occasion_title.tr(),
                    subTitle: LocaleKeys.occasion_occasion_hint.tr(),
                  ),
                  Expanded(
                    child: OccasionsBody(selectedIndex: widget.selectedIndex),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
