import 'package:cinema_app_03/domain/datasources/movies_datasource.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_app_03/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:cinema_app_03/config/constants/environment.dart';

class MovieDBDataSource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbApiKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    final movieDbResponse = MovieDBResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.toMovie(movie))
        .toList();

    return movies;
  }
}
