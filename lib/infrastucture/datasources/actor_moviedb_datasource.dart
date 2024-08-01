import 'package:cinemapedia/config/api/moviedb/moviedb_dio.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastucture/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await MovieDBDio.api.get('/movie/$movieId/credits');

    final movieDBActorsResponse = CreditsResponse.fromJson(response.data);

    return movieDBActorsResponse.cast
        .map((e) => ActorMapper.movieDbCastToEntity(e))
        .toList();
  }
}
