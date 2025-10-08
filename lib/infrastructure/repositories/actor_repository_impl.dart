import 'package:cinema_app_03/domain/datasources/actors_datasource.dart';
import 'package:cinema_app_03/domain/entities/actor.dart';
import 'package:cinema_app_03/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl implements ActorsRepository {
  final ActorsDatasource dataSource;

  ActorRepositoryImpl({required this.dataSource});

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final actors = await dataSource.getActorsByMovieId(movieId);
    return actors;
  }
}
