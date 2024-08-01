import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

class MovieDBDio {
  static final api = Dio(
      BaseOptions(baseUrl: "https://api.themoviedb.org/3", queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": "es-ES",
  }));
}
