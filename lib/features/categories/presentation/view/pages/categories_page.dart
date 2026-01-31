import '../../../../../core/config/di/injectable_config.dart';
import '../../../../filter/presentation/view_model/cubit/filter_cubit.dart';
import '../widgets/categories_body.dart';
import '../../view_model/cubit/categories_cubit.dart';
import '../../view_model/cubit/categories_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, this.incomingIndex});
  final int? incomingIndex;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<CategoriesCubit>()..onEvent(GetAllDataEvent()),
          ),
          BlocProvider(create: (context) => getIt<FilterCubit>()),
          BlocProvider.value(value: getIt<CartCubit>()),
        ],
        child: CategoriesBody(incomingIndex: widget.incomingIndex),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
