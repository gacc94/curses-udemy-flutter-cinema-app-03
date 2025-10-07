import 'package:cinema_app_03/domain/entities/movie.dart';

abstract class MoviesRepository {
  // Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  // Future<List<Movie>> getTopRatedMovies();
  // Future<Movie> getMovieById(int movieId);
  // Future<List<Movie>> searchMovies(String query);
}
