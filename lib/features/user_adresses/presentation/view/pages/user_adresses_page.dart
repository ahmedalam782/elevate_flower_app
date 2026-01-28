import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/features/user_adresses/presentation/view/widgets/user_adresses_body.dart';
import 'package:elevate_flower_app/features/user_adresses/presentation/view_model/cubit/user_adresses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAdressesPage extends StatelessWidget {
  UserAdressesPage({super.key});
  final cubit = getIt<UserAdressesCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.address_address_title.tr())),
      body: BlocProvider<UserAdressesCubit>(
        create: (context) => cubit,
        child: const UserAdressesBody(),
      ),
    );
  }
}
