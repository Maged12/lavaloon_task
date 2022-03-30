import '../data_providers/movies_api.dart';
import '../models/movies_model.dart';

class MoviesRepository {
  Future<Movies> getNowPlayingMovies(int page) async {
    final rawMovies = await MoviesApi().getNowPlaying(page);
    final Movies movies = Movies.fromJson(rawMovies);
    return movies;
  }

  Future<Movies> getWatchList(int accountId, int page, String sessionId) async {
    final rawMovies =
        await MoviesApi().getWatchList(accountId, page, sessionId);
    final Movies movies = Movies.fromJson(rawMovies);
    return movies;
  }

  Future<bool> addToWatchList(int accountId, String sessionId,int movieId) async {
    final body = {"media_type": "movie", "media_id": movieId, "watchlist": true};
    await MoviesApi().addOrRemoveWatchListItem(accountId, sessionId,body);
    return true;
  }
  Future<bool> removeFromWatchList(int accountId, String sessionId,int movieId) async {
    final body = {"media_type": "movie", "media_id": movieId, "watchlist": false};
    await MoviesApi().addOrRemoveWatchListItem(accountId, sessionId,body);
    return true;
  }

}
