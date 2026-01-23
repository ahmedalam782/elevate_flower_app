import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/use_cases/get_profile_data_use_case.dart';
import 'profile_events.dart';
import 'profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._getProfileDataUseCase) : super(ProfileStates());

  final GetProfileDataUseCase _getProfileDataUseCase;

  void doIntent(ProfileEvents event) {
    event.when(loadProfileData: _loadProfileData);
  }

  Future<void> _loadProfileData() async {
    emit(state.copyWith(profileDataState: const BaseState.loading()));

    final result = await _getProfileDataUseCase.call();

    result.when(
      success: (data) {
        emit(state.copyWith(profileDataState: BaseState.success(data)));
      },
      error: (error) {
        emit(state.copyWith(profileDataState: BaseState.error(error)));
      },
    );
  }
}
