sealed class ForgetPasswordEvents {}

class SendOtpToEmailEvent extends ForgetPasswordEvents {}

class VerifyOtpEvent extends ForgetPasswordEvents {
  final String otp;

  VerifyOtpEvent({required this.otp});
}

class TogglePasswordEvent extends ForgetPasswordEvents {
  final bool isConfirmPassword;

  TogglePasswordEvent({required this.isConfirmPassword});
}

class ResetPasswordEvent extends ForgetPasswordEvents {}
