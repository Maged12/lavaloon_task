import 'dart:convert';

import 'package:http/http.dart' as http show get, post;

import '../../core/constants/global.dart';

class MoviesApi {
  Future<String> getNowPlaying(int page) async {
    final response = await http.get(
      Uri.parse(
          "${Global.baseUrl}/movie/now_playing?api_key=${Global.apiKey}&page=$page"),
    );
    if (response.statusCode != 200) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }

  Future<String> getWatchList(int accountId, int page, String sessionId) async {
    final response = await http.get(
      Uri.parse(
        "${Global.baseUrl}/account/$accountId/watchlist/movies?api_key=${Global.apiKey}&language=en-US&session_id=$sessionId&sort_by=created_at.asc&page=$page",
      ),
    );
    if (response.statusCode != 200) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }

  Future<String> addOrRemoveWatchListItem(
      int accountId, String sessionId, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(
          "${Global.baseUrl}/account/$accountId/watchlist?api_key=${Global.apiKey}&session_id=$sessionId"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode != (body["watchlist"] ? 201 : 200)) {
      throw "${json.decode(response.body)['status_message'] ?? "Server Error Please Try again later"}";
    }
    return response.body;
  }
}
