// TODO: presentation ForgetPasswordEvents
sealed class ForgetpasswordEvents {}

class SendOtpToEmailEvent extends ForgetpasswordEvents {}

class VerifyOtpEvent extends ForgetpasswordEvents {
  final String otp;

  VerifyOtpEvent({required this.otp});
}

class TogglePasswordEvent extends ForgetpasswordEvents {
  final bool isConfirmPassword;

  TogglePasswordEvent({required this.isConfirmPassword});
}

class ResetPasswordEvent extends ForgetpasswordEvents {}
