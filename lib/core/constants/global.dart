import 'package:flutter/foundation.dart';
import '../../shared_prefs.dart';

class Global {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static late final SharedPrefs prefs;
  static const String apiKey = "f508559f28d7cf177aa83aa052c571cf";
  static void avoidPrint(message, {StackTrace? trace}) {
    if (kDebugMode) {
      trace ??= StackTrace.current;
      print(trace);
      print(message);
    }
  }
}
