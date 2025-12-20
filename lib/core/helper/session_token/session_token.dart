class SessionToken {
  static final SessionToken _singleton = SessionToken._internal();
  factory SessionToken() => _singleton;
  SessionToken._internal();
  String? _token;
  String? get token => _token;
  set token(String value) => _token = value;
}
