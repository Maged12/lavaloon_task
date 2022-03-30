import '../data_providers/user_api.dart';
import '../models/user_model.dart';

class UserRepository {
  late final String? sessionId;

  UserRepository({this.sessionId});

  Future<User> getUserDetails() async {
    final userJson =
        await UserApi(sessionId: sessionId).getUserDetails();
    final User user = User.fromJson(userJson);
    return user;
  }
}
