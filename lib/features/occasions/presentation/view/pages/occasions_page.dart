import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view/widgets/occasions_app_bar.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view/widgets/occasions_body.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionsPage extends StatefulWidget {
  const OccasionsPage({super.key});

  @override
  State<OccasionsPage> createState() => _OccasionsPageState();
}

class _OccasionsPageState extends State<OccasionsPage> {
  OccasionsCubit get _viewModel => getIt<OccasionsCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel..doIntent(OccasionsEvents.getOccasions()),
      child: BlocBuilder<OccasionsCubit, OccasionsStates>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                OccasionsAppBar(
                  title: LocaleKeys.occasion_occasion_title.tr(),
                  subTitle: LocaleKeys.occasion_occasion_hint.tr(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: OccasionsBody(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
