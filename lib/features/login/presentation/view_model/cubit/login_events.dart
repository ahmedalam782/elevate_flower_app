sealed class LoginEvents {
  const LoginEvents();
  factory LoginEvents.loginUserEvent() = LoginUserEvent;

  void when({required Function() loginUserEvent}) {
    if (this is LoginUserEvent) {
      loginUserEvent();
    }
  }
}

class LoginUserEvent extends LoginEvents {}
