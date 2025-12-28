import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_cubit.dart';
import 'package:elevate_flower_app/features/occasions/presentation/view_model/cubit/occasions_events.dart';
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
    return BlocProvider(
      create: (context) => _viewModel..doIntent(OccasionsEvents.getOccasions()),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () =>
                    _viewModel.doIntent(OccasionsEvents.getOccasions()),
                child: Text('Refresh'),
              ),
              Text('occasions page'),
            ],
          ),
        ),
      ),
    );
  }
}
