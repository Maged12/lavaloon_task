import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/constants/global.dart';

class UserApi {
  late final String? sessionId;

  UserApi({this.sessionId});

  Future<String> getUserDetails() async {
    if (sessionId != null) {
      final response = await http.get(
        Uri.parse(
            "${Global.baseUrl}/account?api_key=${Global.apiKey}&session_id=$sessionId"),
      );
      if (response.statusCode != 200) {
        throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
      }
      return response.body;
    }
    throw "Please login first";
  }
}
