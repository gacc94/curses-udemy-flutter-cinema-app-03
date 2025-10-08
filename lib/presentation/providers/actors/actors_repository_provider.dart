import 'package:cinema_app_03/domain/repositories/actors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_app_03/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinema_app_03/infrastructure/repositories/actor_repository_impl.dart';

final actorRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorRepositoryImpl(dataSource: ActorMoviedbDatasource());
});
