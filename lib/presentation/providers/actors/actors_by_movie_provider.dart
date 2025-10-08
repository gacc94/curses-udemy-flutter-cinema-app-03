import 'package:cinema_app_03/domain/entities/actor.dart';
import 'package:cinema_app_03/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorRepository = ref.watch(actorRepositoryProvider);
      return ActorsByMovieNotifier(
        getActorsByMovieCallback: actorRepository.getActorsByMovieId,
      );
    });

typedef GetActorsByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovieCallback getActorsByMovieCallback;

  ActorsByMovieNotifier({required this.getActorsByMovieCallback}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    final actors = await getActorsByMovieCallback(movieId);
    state = {...state, movieId: actors};
  }
}
