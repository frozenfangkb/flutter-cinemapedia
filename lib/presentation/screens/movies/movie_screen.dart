import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/gradient_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorDetailsProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDescription(movie: movie),
            childCount: 1,
          ),
        )
      ],
    ));
  }
}

class _MovieDescription extends StatelessWidget {
  final Movie movie;

  const _MovieDescription({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  width: size.width * 0.3,
                  movie.posterPath,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )))
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Actores', style: textStyles.titleLarge),
        ),
        const SizedBox(height: 10),
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorDetailsProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    width: 135,
                    height: 180,
                    fit: BoxFit.cover,
                    actor.profilePath,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const SizedBox();
                      }

                      return FadeIn(child: child);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(actor.name, maxLines: 2),
                Text(actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavouriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) async {
  return ref.watch(localStorageRepositoryProvider).isMovieFavourite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavouriteFuture = ref.watch(isFavouriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favouriteMoviesProvider.notifier)
                .toggleFavourite(movie);
            ref.invalidate(isFavouriteProvider(movie.id));
          },
          icon: isFavouriteFuture.when(
              data: (isFavourite) => isFavourite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const CircularProgressIndicator(strokeWidth: 2)),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const SizedBox.expand(
                    child: ColoredBox(color: Colors.black),
                  );
                }

                return FadeIn(child: child);
              },
            ),
          ),
          const GradientCover(
            colors: [Colors.transparent, Colors.black87],
            endAlignment: Alignment.bottomCenter,
            startAlignment: Alignment.topCenter,
            stops: [0.8, 1],
          ),
          const GradientCover(
            colors: [Colors.black87, Colors.transparent],
            endAlignment: Alignment.center,
            startAlignment: Alignment.topLeft,
            stops: [0, 0.4],
          ),
          const GradientCover(
            colors: [Colors.black87, Colors.transparent],
            endAlignment: Alignment.center,
            startAlignment: Alignment.topRight,
            stops: [0, 0.4],
          ),
        ]),
      ),
    );
  }
}
