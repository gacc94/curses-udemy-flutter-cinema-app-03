import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinema_app_03/config/helpers/human_formats.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMoviesCb;
  List<Movie> initialMovies;
  final StreamController<List<Movie>> _debounceMovies =
      StreamController<List<Movie>>.broadcast();
  Timer? _debounceTimer;

  StreamController<bool> isLoadingStream = StreamController<bool>.broadcast();

  SearchMovieDelegate({
    required this.searchMoviesCb,
    required this.initialMovies,
  });

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMoviesCb(query);
      initialMovies = movies;
      _debounceMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  void clearStream() {
    _debounceMovies.close();
    _debounceTimer?.cancel();
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          return isLoading
              ? SpinPerfect(
                  duration: const Duration(seconds: 20),
                  infinite: true,
                  spins: 10,
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: () {
                      query = '';
                      clearStream();
                    },
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () {
                    query = '';
                    clearStream();
                  },
                );
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return FadeIn(
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
          clearStream();
          close(context, null);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: _debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onSelected: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      initialData: initialMovies,
      stream: _debounceMovies.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onSelected: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildResultsAndSuggestings() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: _debounceMovies.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onSelected: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onSelected;
  const _MovieItem({required this.movie, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            //*IMAGE
            FadeIn(
              animate: true,
              child: SizedBox(
                width: size.width * 0.2,
                // height: size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            //*Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*Title
                  Text(movie.title, style: theme.textTheme.titleMedium),

                  //*Overview
                  Text(
                    movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),

                  //*Rating
                  Row(
                    children: [
                      Icon(Icons.star_half_outlined, color: Colors.amber),
                      Text(
                        HumanFormats.numberDecimal(
                          movie.voteAverage,
                          decimals: 1,
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
