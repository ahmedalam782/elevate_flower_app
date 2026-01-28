import 'package:elevate_flower_app/features/user_adresses/presentation/view_model/cubit/user_adresses_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class UserAdressesCubit extends Cubit<UserAdressesStates> {
  UserAdressesCubit() : super(UserAdressesStates());
}
