import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/entities/user_address_entity.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/use_cases/delete_user_address_usecase.dart';
import 'package:elevate_flower_app/features/user_addresses/domain/use_cases/get_all_addresses_usecase.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_events.dart';
import 'package:elevate_flower_app/features/user_addresses/presentation/view_model/cubit/user_addresses_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserAddressesCubit extends Cubit<UserAddressesStates> {
  UserAddressesCubit(
    this._getAllAddressesUsecase,
    this._deleteUserAddressUsecase,
  ) : super(UserAddressesStates());
  final GetAllAddressesUsecase _getAllAddressesUsecase;
  final DeleteUserAddressUsecase _deleteUserAddressUsecase;

  void doIntent(UserAddressesEvent event) {
    event.when(
      getAllAddresses: _getAllAddresses,
      deleteAddress: _deleteAddress,
    );
  }

  void _getAllAddresses() async {
    emit(state.copyWith(getUserAddressesState: const BaseState.loading()));
    final result = await _getAllAddressesUsecase.call();
    result.when(
      success: (data) {
        emit(state.copyWith(getUserAddressesState: BaseState.success(data)));
      },
      error: (error) {
        emit(state.copyWith(getUserAddressesState: BaseState.error(error)));
      },
    );
  }

  void _deleteAddress(String id) async {
    final currentList = List<UserAddressEntity>.from(
      state.getUserAddressesState.data ?? [],
    );

    currentList.removeWhere((e) => e.id == id);

    final result = await _deleteUserAddressUsecase.call(id);
    result.when(
      success: (data) {
        emit(
          state.copyWith(getUserAddressesState: BaseState.success(currentList)),
        );
      },
      error: (error) {
        emit(state.copyWith(getUserAddressesState: BaseState.error(error)));
      },
    );
  }
}
// fake push