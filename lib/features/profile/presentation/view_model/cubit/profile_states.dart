import '../../../../../core/config/base_state/base_state.dart';
import '../../../domain/entities/profile_data_entity.dart';

class ProfileStates {
  ProfileStates({this.profileDataState = const BaseState.initial()});

  final BaseState<ProfileDataEntity> profileDataState;

  ProfileStates copyWith({BaseState<ProfileDataEntity>? profileDataState}) {
    return ProfileStates(
      profileDataState: profileDataState ?? this.profileDataState,
    );
  }
}
