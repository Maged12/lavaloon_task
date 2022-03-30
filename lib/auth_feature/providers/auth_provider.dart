import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../repositories/auth_repo.dart';
import '../../core/constants/global.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _sessionId;
  bool? _isValid;
  String _errorMessage = "";
  bool _isLoading = false;

  String? get token {
    return _token;
  }

  bool get isLoading {
    return _isLoading;
  }

  bool? get isValid {
    return _isValid;
  }

  String get errorMessage {
    return _errorMessage;
  }

  String? get sessionId {
    return _sessionId;
  }

  set setSessionId(String sessionId) => _sessionId = sessionId;

  Future<void> getRequestedToken() async {
    try {
      _isLoading = true;
      notifyListeners();
      _token = await AuthRepository().getRequestedToken();
    } catch (err) {
      Global.avoidPrint(err);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createSession() async {
    try {
      _isLoading = true;
      notifyListeners();
      _sessionId = await AuthRepository().createSession(_token!);
    } catch (err) {
      Global.avoidPrint(err);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> validateLogin(String userName, String passWord) async {
    try {
      _isLoading = true;
      notifyListeners();
      _isValid =
          await AuthRepository().validateLogin(userName, passWord, _token!);
      _errorMessage = '';
    } catch (err) {
      _isValid = false;
      _errorMessage = err.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
