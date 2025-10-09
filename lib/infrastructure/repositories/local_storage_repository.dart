import 'package:cinema_app_03/domain/datasources/local_storage_datasources.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource localStorageDatasource;

  LocalStorageRepositoryImpl(this.localStorageDatasource);

  @override
  Future<void> toggleFavoriteMovie(Movie movie) =>
      localStorageDatasource.toggleFavoriteMovie(movie);

  @override
  Future<bool> isMovieFavorite(int movieId) =>
      localStorageDatasource.isMovieFavorite(movieId);

  @override
  Future<List<Movie>> loadFavoritesMovies({int limit = 10, int offset = 0}) =>
      localStorageDatasource.loadFavoritesMovies(limit: limit, offset: offset);
}
