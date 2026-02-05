import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../widgets/best_seller_body.dart';
import '../../view_model/cubit/best_seller_cubit.dart';
import '../../view_model/cubit/best_seller_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/presentation/view_model/cubit/cart_cubit.dart';

class BestSellerPage extends StatelessWidget {
  BestSellerPage({super.key});
  final cubit = getIt<BestSellerCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.best_seller_best_seller.tr()),
      body: BlocProvider<BestSellerCubit>(
        create: (context) =>
            cubit..doIntent(BestSellerEvents.getBestSellerProducts()),
        child: BlocProvider.value(
          value: getIt<CartCubit>(),
          child: const BestSellerBody(),
        ),
      ),
    );
  }
}
