import 'dart:io';

import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_user_entity.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';

class EditProfileStates {
  const EditProfileStates({
    this.editProfileState,
    this.getProfileState = const BaseState.initial(),
    this.genderRowState,
    this.isFormChanged = false,
    this.pickedPhoto,
    this.updatePhotoState,
  });

  final BaseState<EditProfileUserEntity>? editProfileState;
  final BaseState<EditProfileUserEntity> getProfileState;
  final GenderRowState? genderRowState;
  final bool isFormChanged;
  final File? pickedPhoto;
  final BaseState<String>? updatePhotoState;

  EditProfileStates copyWith({
    BaseState<EditProfileUserEntity>? editProfileState,
    BaseState<EditProfileUserEntity>? getProfileState,
    GenderRowState? genderRowState,
    bool? isFormChanged,
    File? pickedPhoto,
    BaseState<String>? updatePhotoState,
  }) {
    return EditProfileStates(
      editProfileState: editProfileState ?? this.editProfileState,
      getProfileState: getProfileState ?? this.getProfileState,
      genderRowState: genderRowState ?? this.genderRowState,
      isFormChanged: isFormChanged ?? this.isFormChanged,
      pickedPhoto: pickedPhoto ?? this.pickedPhoto,
      updatePhotoState: updatePhotoState ?? this.updatePhotoState,
    );
  }
}
