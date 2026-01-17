import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_app_bar.dart';
import 'package:elevate_flower_app/features/register/presentation/view/widgets/register_body.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<RegisterCubit>();
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.register_register_title.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: BlocProvider<RegisterCubit>(
              create: (context) => cubit,
              child: const RegisterBody(),
            ),
          ),
        ),
      ),
    );
  }
}
