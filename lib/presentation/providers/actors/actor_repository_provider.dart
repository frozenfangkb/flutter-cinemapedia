import 'package:cinemapedia/infrastucture/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider(
    (ref) => ActorRepositoryImpl(datasource: ActorMoviedbDatasource()));
