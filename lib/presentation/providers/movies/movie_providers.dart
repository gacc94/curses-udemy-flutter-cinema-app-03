import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider).getNowPlaying;
      return MoviesNotifier(fetchMoreMovies: movieRepository);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoreMovies: movieRepository);
    });

typedef MoviesNotifierCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MoviesNotifierCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
