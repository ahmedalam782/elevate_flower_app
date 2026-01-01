import 'package:elevate_flower_app/features/categories/presentation/view/widgets/categories_body.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/di/injectable_config.dart';
    
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesCubit>()..onEvent(GetAllDataEvent()),
      child: const CategoriesBody(),
    );
  }
}
