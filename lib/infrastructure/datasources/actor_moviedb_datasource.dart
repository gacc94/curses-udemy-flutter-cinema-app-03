import 'package:cinema_app_03/domain/entities/actor.dart';
import 'package:cinema_app_03/domain/datasources/actors_datasource.dart';
import 'package:cinema_app_03/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema_app_03/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';
import 'package:cinema_app_03/config/constants/environment.dart';

class ActorMoviedbDatasource implements ActorsDatasource {
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
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(response.data);
    return creditsResponse.cast.map((e) => ActorMapper.toActor(e)).toList();
  }
}
