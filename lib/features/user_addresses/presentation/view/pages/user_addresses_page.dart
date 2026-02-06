import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../widgets/user_addresses_body.dart';
import '../../view_model/cubit/user_addresses_cubit.dart';
import '../../view_model/cubit/user_addresses_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddressesPage extends StatelessWidget {
  UserAddressesPage({super.key});
  final cubit = getIt<UserAddressesCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.address_address_title.tr())),
      body: BlocProvider<UserAddressesCubit>(
        create: (context) =>
            cubit..doIntent(UserAddressesEvent.getAllAddresses()),
        child: const UserAddressesBody(),
      ),
    );
  }
}
