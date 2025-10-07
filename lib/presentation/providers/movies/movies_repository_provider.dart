import 'package:cinema_app_03/domain/repositories/movies_repository.dart';
import 'package:cinema_app_03/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinema_app_03/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider<MoviesRepository>(
  (ref) => MovieRepositoryImpl(dataSource: MovieDBDataSource()),
);
