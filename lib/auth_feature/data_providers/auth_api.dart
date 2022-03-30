import 'dart:convert';

import 'package:http/http.dart' as http show get, post;
import '../../core/constants/global.dart';

class AuthApi {
  Future<String> getRequestedToken() async {
    final response = await http.get(
      Uri.parse(
          "${Global.baseUrl}/authentication/token/new?api_key=${Global.apiKey}"),
    );
    if (response.statusCode != 200) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }

  Future<String> createSession(String token) async {
    final response = await http.post(
      Uri.parse(
          "${Global.baseUrl}/authentication/session/new?api_key=${Global.apiKey}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"request_token": token}),
    );
    if (response.statusCode != 200) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }

  Future<String> validateLogin(
      String userName, String passWord, String token) async {
    final response = await http.post(
      Uri.parse(
          "${Global.baseUrl}/authentication/token/validate_with_login?api_key=${Global.apiKey}"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {"username": userName, "password": passWord, "request_token": token}),
    );
    if (response.statusCode != 200) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }
}
