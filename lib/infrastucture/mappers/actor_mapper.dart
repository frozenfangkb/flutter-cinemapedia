import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor movieDbCastToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://upload.wikimedia.org/wikipedia/commons/a/af/Default_avatar_profile.jpg',
      character: cast.character,
    );
  }
}
