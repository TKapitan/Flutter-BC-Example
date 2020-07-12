class SessionManager {
  static final SessionManager _singleton = SessionManager._singletonConst();

  SessionManager._singletonConst();
  factory SessionManager() {
    return _singleton;
  }
}
