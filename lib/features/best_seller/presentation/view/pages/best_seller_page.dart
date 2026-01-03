import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_app_bar.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view/widgets/best_seller_body.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart';
import 'package:elevate_flower_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: const BestSellerBody(),
      ),
    );
  }
}
