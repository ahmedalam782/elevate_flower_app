import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/occasions_app_bar.dart';
import '../widgets/occasions_body.dart';
import '../../view_model/cubit/occasions_cubit.dart';
import '../../view_model/cubit/occasions_events.dart';
import '../../view_model/cubit/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';

class OccasionsPage extends StatefulWidget {
  const OccasionsPage({super.key, this.selectedIndex});
  final int? selectedIndex;
  @override
  State<OccasionsPage> createState() => _OccasionsPageState();
}

class _OccasionsPageState extends State<OccasionsPage> {
  OccasionsCubit get _viewModel => getIt<OccasionsCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel..doIntent(OccasionsEvents.getOccasions()),
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
