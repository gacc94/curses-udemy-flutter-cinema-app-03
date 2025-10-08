import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/delegates/serach_movie_delegate.dart';
import 'package:cinema_app_03/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final tittleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: size.width,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 5),
              Text('Cinema App', style: tittleStyle),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final searchQuery = ref.read(searchMoviesProvider);
                  final movies = ref.read(searchMoviesStreamProvider);

                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMoviesCb: ref
                          .read(searchMoviesStreamProvider.notifier)
                          .searchMoviesByQuery,
                      initialMovies: movies,
                    ),
                  );

                  if (movie == null) return;
                  if (!context.mounted) return;

                  context.push('/movie/${movie.id}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
