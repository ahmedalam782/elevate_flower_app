import '../../../../../core/utils/enums/gender.dart';
import 'package:image_picker/image_picker.dart';

sealed class EditProfileEvents {
  const EditProfileEvents();
  factory EditProfileEvents.fillFormEvent() = FillFormEvent;
  factory EditProfileEvents.checkFormChangedEvent() = CheckFormChangedEvent;
  factory EditProfileEvents.onUpdateEvent() = OnUpdateEvent;
  factory EditProfileEvents.onGenderSelectedEvent(Gender? gender) =
      OnGenderSelectedEvent;
  factory EditProfileEvents.onPickProfilePhotoEvent(ImageSource source) =
      OnPickProfilePhotoEvent;
  void when({
    required void Function() fillFormEvent,
    required void Function() checkFormChangedEvent,
    required void Function() onUpdateEvent,
    required void Function(Gender? gender) onGenderSelectedEvent,
    required void Function(ImageSource source) onPickProfilePhotoEvent,
  }) {
    if (this is FillFormEvent) {
      fillFormEvent();
    } else if (this is CheckFormChangedEvent) {
      checkFormChangedEvent();
    } else if (this is OnUpdateEvent) {
      onUpdateEvent();
    } else if (this is OnGenderSelectedEvent) {
      onGenderSelectedEvent((this as OnGenderSelectedEvent).gender);
    } else if (this is OnPickProfilePhotoEvent) {
      onPickProfilePhotoEvent((this as OnPickProfilePhotoEvent).source);
    }
  }
}

class FillFormEvent extends EditProfileEvents {}

class CheckFormChangedEvent extends EditProfileEvents {}

class OnUpdateEvent extends EditProfileEvents {}

class OnGenderSelectedEvent extends EditProfileEvents {
  final Gender? gender;
  OnGenderSelectedEvent(this.gender);
}

class OnPickProfilePhotoEvent extends EditProfileEvents {
  final ImageSource source;
  OnPickProfilePhotoEvent(this.source);
}
