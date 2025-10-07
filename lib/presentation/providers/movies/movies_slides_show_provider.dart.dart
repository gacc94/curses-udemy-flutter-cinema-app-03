import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/providers/movies/movie_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.take(6).toList();
});
