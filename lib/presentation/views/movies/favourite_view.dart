import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavouriteView extends ConsumerStatefulWidget {
  const FavouriteView({super.key});

  @override
  FavouriteViewState createState() => FavouriteViewState();
}

class FavouriteViewState extends ConsumerState<FavouriteView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final List<Movie> movies =
        await ref.read(favouriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    if (favouriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('¡Ups!',
                style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text('No tienes películas favoritas',
                style: TextStyle(fontSize: 20, color: Colors.black45)),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favouriteMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
