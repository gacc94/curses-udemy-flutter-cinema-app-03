import 'package:cinema_app_03/config/database/database.dart';
import 'package:cinema_app_03/domain/datasources/local_storage_datasources.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:drift/drift.dart' as drift;

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase? database;

  DriftDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    if (database == null) return;
    final isFavorite = await isMovieFavorite(movie.id);

    if (isFavorite) {
      final deleteQuery = database!.delete(database!.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteQuery.go();
      return;
    } else {
      final favoriteMovie = FavoriteMoviesCompanion.insert(
        movieId: movie.id,
        backdropPath: movie.backdropPath,
        posterPath: movie.posterPath,
        originalTitle: movie.originalTitle,
        title: movie.title,
        voteAverage: drift.Value(movie.voteAverage),
      );

      await database!.into(database!.favoriteMovies).insert(favoriteMovie);
      return;
    }
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    if (database == null) return Future.value(false);
    final query = database!.select(database!.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));

    final favoriteMovie = await query.getSingleOrNull();

    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoritesMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    final query = database!.select(database!.favoriteMovies)
      ..limit(limit, offset: offset);

    final favoriteMovies = await query.get();
    final movies = favoriteMovies
        .map(
          (row) => Movie(
            adult: false,
            backdropPath: row.backdropPath,
            genreIds: const [],
            id: row.movieId,
            originalLanguage: '',
            originalTitle: row.originalTitle,
            overview: '',
            popularity: 0,
            posterPath: row.posterPath,
            releaseDate: DateTime.now(),
            title: row.title,
            video: false,
            voteAverage: row.voteAverage,
            voteCount: 0,
          ),
        )
        .toList();

    return movies;
  }
}
