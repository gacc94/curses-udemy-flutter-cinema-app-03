import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchMoviesProvider = StateProvider<String>((ref) => '');

final searchMoviesStreamProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider);
      return SearchMoviesNotifier(
        searchMoviesCb: movieRepository.searchMovies,
        ref: ref,
      );
    });

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMoviesCb;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMoviesCb, required this.ref})
    : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final movies = await searchMoviesCb(query);
    ref.read(searchMoviesProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
