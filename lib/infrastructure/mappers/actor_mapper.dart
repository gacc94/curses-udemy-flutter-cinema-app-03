import 'package:cinema_app_03/domain/entities/actor.dart';
import 'package:cinema_app_03/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor toActor(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}.jpg'
          : 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      character: cast.character ?? '',
    );
  }
}
