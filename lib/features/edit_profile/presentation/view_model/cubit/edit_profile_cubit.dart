import 'dart:async';
import 'dart:io';
import 'package:elevate_flower_app/core/config/base_state/base_state.dart';
import 'package:elevate_flower_app/core/errors/handle_errors/handle_errors.dart';
import 'package:elevate_flower_app/core/utils/enums/gender.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_params.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_result.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/entities/edit_profile_user_entity.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/use_cases/get_profile_details_usecase.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/use_cases/update_profile_details_usecase.dart';
import 'package:elevate_flower_app/features/edit_profile/domain/use_cases/update_profile_photo_usecase.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:elevate_flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';
import 'package:elevate_flower_app/features/register/presentation/view_model/cubit/register_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit(
    this._updateProfileDetailsUsecase,
    this._getProfileDetailsUsecase,
    this._updateProfilePhotoUsecase,
  ) : super(const EditProfileStates());

  final UpdateProfileDetailsUsecase _updateProfileDetailsUsecase;
  final GetProfileDetailsUsecase _getProfileDetailsUsecase;
  final UpdateProfilePhotoUsecase _updateProfilePhotoUsecase;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  final _updateResultController =
      StreamController<EditProfileResult>.broadcast();
  Stream<EditProfileResult> get updateResultStream =>
      _updateResultController.stream;

  void onEvent(EditProfileEvents event) {
    event.when(
      fillFormEvent: _fillForm,
      checkFormChangedEvent: _checkFormChanged,
      onUpdateEvent: _onUpdateButtonPressed,
      onGenderSelectedEvent: _onGenderSelected,
      onPickProfilePhotoEvent: _pickProfilePhoto,
    );
  }

  // -------------------- Fill Form --------------------
  void _fillForm() async {
    emit(state.copyWith(getProfileState: const BaseState.loading()));

    final result = await _getProfileDetailsUsecase();
    result.when(
      success: (data) {
        if (data == null) return;
        _initControllers(data);
        emit(
          state.copyWith(
            getProfileState: BaseState.success(data),
            genderRowState: (state.genderRowState ?? const GenderRowState())
                .copyWith(
                  selectedGender: GenderParsing.fromString(data.gender),
                ),
          ),
        );
      },
      error: (error) {
        emit(state.copyWith(getProfileState: BaseState.error(error)));
      },
    );
  }

  void _initControllers(EditProfileUserEntity user) {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email ?? '';
    phoneNumberController.text = user.phoneNumber ?? '';
    passwordController.text = 'randompassword';
  }

  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> _requestGalleryPermission() async {
    if (Platform.isAndroid) {
      // Android 13+
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  // -------------------- Pick Photo --------------------
  Future<void> _pickProfilePhoto(ImageSource source) async {
    bool hasPermission = false;

    if (source == ImageSource.camera) {
      hasPermission = await _requestCameraPermission();
    } else {
      hasPermission = await _requestGalleryPermission();
    }

    if (!hasPermission) {
      _updateResultController.add(
        EditProfileResult.error('Permission camera or gallery denied'),
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      // Compress the image
      final rawBytes = await File(pickedFile.path).readAsBytes();
      final processedImage = await _processImage(
        rawBytes,
        fileName: pickedFile.name,
      );
      if (processedImage != null && processedImage['file'] != null) {
        emit(state.copyWith(pickedPhoto: processedImage['file'] as File));
        _checkFormChanged();
      } else {
        _updateResultController.add(
          EditProfileResult.error('Failed to compress image'),
        );
      }
    }
  }

  // -------------------- Process Image --------------------
  static Future<Map<String, dynamic>?> _processImage(
    Uint8List rawBytes, {
    String? fileName,
  }) async {
    try {
      final decoded = img.decodeImage(rawBytes);
      if (decoded == null) return null;

      // Resize and compress
      final resized = img.copyResize(decoded, width: 1024); // max width
      final compressedBytes = Uint8List.fromList(
        img.encodeJpg(resized, quality: 85),
      );

      File? tempFile;
      if (!kIsWeb) {
        final tempDir = await getTemporaryDirectory();
        final tempPath = p.join(
          tempDir.path,
          fileName ?? "image_${DateTime.now().millisecondsSinceEpoch}.jpg",
        );
        tempFile = await File(tempPath).writeAsBytes(compressedBytes);
      }

      return {'file': tempFile, 'bytes': compressedBytes, 'fileName': fileName};
    } catch (e) {
      debugPrint("Image processing error: $e");
      return null;
    }
  }

  // -------------------- Update Button Pressed --------------------
  void _onUpdateButtonPressed() async {
    if (state.pickedPhoto != null) await _updatePhoto();
    if (state.isFormChanged) await _updateProfile();

    final photoSuccess =
        state.pickedPhoto == null ||
        state.updatePhotoState?.state == StateType.success;
    final detailsSuccess =
        !state.isFormChanged ||
        state.editProfileState?.state == StateType.success;
    if (photoSuccess && detailsSuccess) {
      _updateResultController.add(EditProfileResult.success());
    } else {
      String? message;
      if (state.updatePhotoState?.state == StateType.error) {
        message = handleError(state.updatePhotoState!.exception);
        _updateResultController.add(EditProfileResult.error(message));
      } else if (state.editProfileState?.state == StateType.error) {
        message = handleError(state.editProfileState!.exception);
        _updateResultController.add(EditProfileResult.error(message));
      }
    }
  }

  // -------------------- Update Photo --------------------
  Future<void> _updatePhoto() async {
    if (state.pickedPhoto == null) return;

    emit(state.copyWith(updatePhotoState: const BaseState.loading()));

    final result = await _updateProfilePhotoUsecase(state.pickedPhoto!);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            updatePhotoState: BaseState.success(data),
            pickedPhoto: null,
          ),
        );
      },
      error: (error) {
        emit(state.copyWith(updatePhotoState: BaseState.error(error)));
      },
    );
  }

  // -------------------- Update Profile --------------------
  Future<void> _updateProfile() async {
    if (!state.isFormChanged) return;
    if (formKey.currentState?.validate() != true) return;
    final user = state.getProfileState.data;
    if (user == null) return;

    final params = EditProfileParams(
      firstName: firstNameController.text.trim() != user.firstName
          ? firstNameController.text
          : null,
      lastName: lastNameController.text.trim() != user.lastName
          ? lastNameController.text
          : null,
      email: emailController.text.trim() != user.email
          ? emailController.text
          : null,
      phoneNumber: phoneNumberController.text.trim() != user.phoneNumber
          ? phoneNumberController.text
          : null,
      gender: state.genderRowState?.selectedGender?.name != user.gender
          ? state.genderRowState?.selectedGender?.name
          : null,
    );

    emit(state.copyWith(editProfileState: const BaseState.loading()));

    final result = await _updateProfileDetailsUsecase(params);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            editProfileState: BaseState.success(data),
            isFormChanged: false,
          ),
        );
      },
      error: (error) {
        emit(state.copyWith(editProfileState: BaseState.error(error)));
      },
    );
  }

  // -------------------- Gender Selection --------------------
  void _onGenderSelected(Gender? gender) {
    emit(
      state.copyWith(
        genderRowState: state.genderRowState?.copyWith(
          selectedGender: gender,
          showGenderError: gender == null,
        ),
      ),
    );
    _checkFormChanged();
  }

  // -------------------- Check Form Changes --------------------
  void _checkFormChanged() {
    final user = state.getProfileState.data;
    if (user == null) return;

    final changed =
        user.firstName != firstNameController.text.trim() ||
        user.lastName?.trim() != lastNameController.text.trim() ||
        user.email != emailController.text.trim() ||
        user.phoneNumber != phoneNumberController.text.trim() ||
        user.gender != state.genderRowState?.selectedGender?.name ||
        (state.pickedPhoto != null);

    if (changed != state.isFormChanged) {
      emit(state.copyWith(isFormChanged: changed));
    }
  }

  // -------------------- Dispose Stream --------------------
  @override
  Future<void> close() {
    _updateResultController.close();
    return super.close();
  }
}
