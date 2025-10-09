import 'package:flutter_riverpod/legacy.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/domain/repositories/local_storage_repository.dart';
import 'package:cinema_app_03/presentation/providers/storages/local_storage_provider.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
      return StorageMoviesNotifier(
        localStorageRepository: ref.watch(localStoragesRepositoryProvider),
      );
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  final LocalStorageRepository localStorageRepository;
  int page = 0;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoritesMovies(
      limit: 10,
      offset: page * 10,
    );
    page++;

    final Map<int, Movie> newMovies = {};

    for (final movie in movies) {
      newMovies[movie.id] = movie;
    }
    state = {...state, ...newMovies};
    return movies;
  }

  Future<void> toogleFavoriteMovie(Movie movie) async {
    final isFavorite = await localStorageRepository.isMovieFavorite(movie.id);
    await localStorageRepository.toggleFavoriteMovie(movie);

    if (!isFavorite) {
      state.remove(movie.id);
      state = {...state};
      return;
    }

    state = {...state, movie.id: movie};
  }
}
