import 'package:cinemapedia/infrastucture/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This repository is immutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
