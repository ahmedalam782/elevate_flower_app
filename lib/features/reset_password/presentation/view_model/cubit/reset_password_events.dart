sealed class ResetPasswordEvents {
  const ResetPasswordEvents();

  factory ResetPasswordEvents.changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) = ChangePasswordEvent;

  void when({
    required void Function(
      String currentPassword,
      String newPassword,
      String confirmPassword,
    )
    changePassword,
  }) {
    if (this is ChangePasswordEvent) {
      final event = this as ChangePasswordEvent;
      changePassword(
        event.currentPassword,
        event.newPassword,
        event.confirmPassword,
      );
    }
  }
}

class ChangePasswordEvent extends ResetPasswordEvents {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
