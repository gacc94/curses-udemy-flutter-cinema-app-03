import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider);
      return MovieMapNotifier(getMovieCallback: movieRepository.getMovieById);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieCallback;
  MovieMapNotifier({required this.getMovieCallback}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovieCallback(movieId);
    state = {...state, movieId: movie};
  }
}
