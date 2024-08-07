import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavourite(int movieId) {
    // TODO: implement isMovieFavourite
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavourite(Movie movie) {
    // TODO: implement toggleFavourite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }
}
