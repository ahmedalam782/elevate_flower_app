import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../widgets/forget_password_body.dart';

class ForgetPasswordPage extends StatelessWidget {
   ForgetPasswordPage({super.key});
   final ForgetPasswordCubit viewModel = getIt<ForgetPasswordCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: AppColors.whiteF9,
        appBar: CustomAppBar(title: LocaleKeys.forget_password_password.tr()),

        body: ForgetPasswordBody(
          viewModel: viewModel,
        ),
      ),
    );
  }
}
