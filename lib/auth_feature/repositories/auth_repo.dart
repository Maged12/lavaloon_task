import 'dart:convert';

import '../data_providers/auth_api.dart';
import '../../core/constants/global.dart';
import '../../core/constants/strings.dart';

class AuthRepository {
  Future<String> getRequestedToken() async {
    final String rawRequestedToken = await AuthApi().getRequestedToken();
    return json.decode(rawRequestedToken)["request_token"];
  }

  Future<String> createSession(String token) async {
    final String rawSessionId = await AuthApi().createSession(token);
    final String sessionId = json.decode(rawSessionId)["session_id"];
    Global.prefs.setString(Strings.sessionIdKey, sessionId);
    return sessionId;
  }

  Future<bool> validateLogin(
      String userName, String passWord, String token) async {
    await AuthApi().validateLogin(userName, passWord, token);
    return true;
  }
}
