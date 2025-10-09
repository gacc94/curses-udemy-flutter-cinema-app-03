import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_app_03/presentation/providers/storages/local_storage_provider.dart';

final isFavoriteMovieProvider = FutureProvider.family<bool, int>((
  ref,
  movieId,
) async {
  final localStorageRepository = ref.watch(localStoragesRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});
