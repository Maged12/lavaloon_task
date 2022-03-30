import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../core/constants/global.dart';
import '../../core/constants/strings.dart';
import '../models/user_model.dart';
import '../repositories/user_repo.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user {
    return _user;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<void> getUserData(String sessionId, String apiKey) async {
    try {
      _isLoading = true;
      notifyListeners();
      _user = await UserRepository(sessionId: sessionId)
          .getUserDetails();
      Global.prefs.setInt(Strings.userIdKey, _user!.id!);
    } catch (err) {
      Global.avoidPrint(err);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
