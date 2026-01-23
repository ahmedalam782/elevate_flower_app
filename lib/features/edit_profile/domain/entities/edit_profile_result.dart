class EditProfileResult {
  final bool success;
  final String? message;
  EditProfileResult.success() : success = true, message = null;
  EditProfileResult.error(this.message) : success = false;
}
