import 'package:flutter/foundation.dart';
import '../models/movies_model.dart';
import '../repositories/movies_repo.dart';
import '../../core/constants/global.dart';

class WatchListProvider extends ChangeNotifier {
  bool _isLoading = false;

  Movies? _watchList;

  Movies? get watchList {
    return _watchList;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<void> getWatchList(int accountId, int page, String sessionId) async {
    try {
      _isLoading = true;
      notifyListeners();
      _watchList =
          await MoviesRepository().getWatchList(accountId, page, sessionId);
    } catch (err, trace) {
      Global.avoidPrint(err, trace: trace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToWatchList(int accountId, String sessionId,int movieId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final isSuccesAdd =
          await MoviesRepository().addToWatchList(accountId, sessionId,movieId);
      _isLoading = false;
      notifyListeners();
      return isSuccesAdd;
    } catch (err, trace) {
      Global.avoidPrint(err, trace: trace);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromWatchList(int accountId, String sessionId,int movieId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final isRemoved =
      await MoviesRepository().removeFromWatchList(accountId, sessionId,movieId);
      _isLoading = false;
      notifyListeners();
      return isRemoved;
    } catch (err, trace) {
      Global.avoidPrint(err, trace: trace);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
