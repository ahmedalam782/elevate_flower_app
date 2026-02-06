import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_app_bar.dart';
import '../widgets/register_body.dart';
import '../../view_model/cubit/register_cubit.dart';
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
