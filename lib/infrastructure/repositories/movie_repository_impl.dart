import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/domain/repositories/movies_repository.dart';
import 'package:cinema_app_03/infrastructure/datasources/moviedb_datasource.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MovieDBDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final movies = await dataSource.getNowPlaying(page: page);
    return movies;
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final movies = await dataSource.getPopular(page: page);
    return movies;
  }
}
