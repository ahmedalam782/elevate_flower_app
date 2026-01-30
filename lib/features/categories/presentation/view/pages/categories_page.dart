import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/categories/presentation/view/widgets/categories_body.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:elevate_flower_app/features/categories/presentation/view_model/cubit/categories_events.dart';
import 'package:elevate_flower_app/features/filter/presentation/view_model/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/di/injectable_config.dart';

import 'package:elevate_flower_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, this.incomingIndex});
  final int? incomingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            getIt<CategoriesCubit>()..onEvent(GetAllDataEvent()),
        child: BlocProvider.value(
          value: getIt<CartCubit>(),
          child: CategoriesBody(incomingIndex: incomingIndex),
        ),
      ),
    );
  }
}