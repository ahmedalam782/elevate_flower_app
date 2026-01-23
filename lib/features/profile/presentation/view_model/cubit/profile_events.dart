sealed class ProfileEvents {
  const ProfileEvents();

  factory ProfileEvents.loadProfileData() = LoadProfileDataEvent;

  void when({required Function() loadProfileData}) {
    if (this is LoadProfileDataEvent) {
      loadProfileData();
    }
  }
}

class LoadProfileDataEvent extends ProfileEvents {}
