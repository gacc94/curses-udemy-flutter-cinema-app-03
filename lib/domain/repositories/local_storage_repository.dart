import 'package:cinema_app_03/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavoriteMovie(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadFavoritesMovies({int limit = 10, int offset = 0});
}
