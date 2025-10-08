import 'package:cinema_app_03/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovieId(String movieId);
}
