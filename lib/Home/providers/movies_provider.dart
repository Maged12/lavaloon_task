import 'package:flutter/foundation.dart';
import '../models/movies_model.dart';
import '../repositories/movies_repo.dart';
import '../../core/constants/global.dart';

class MoviesProvider extends ChangeNotifier {
  bool _isLoading = false;

  Movies? _nowPlaying;

  Movies? get nowPlaying {
    return _nowPlaying;
  }

  bool get isLoading {
    return _isLoading;
  }

  Future<void> getNowPlayingList(int page) async {
    try {
      _isLoading = true;
      notifyListeners();
      _nowPlaying = await MoviesRepository().getNowPlayingMovies(page);
    } catch (err, trace) {
      Global.avoidPrint(err, trace: trace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
