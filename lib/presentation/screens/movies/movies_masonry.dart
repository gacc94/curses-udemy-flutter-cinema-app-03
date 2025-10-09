import 'package:cinema_app_03/presentation/screens/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movies;
  final Future<List<Movie>> Function()? loadNextPage;
  const MoviesMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  bool isLastPage = false;
  bool isLoadingPage = false;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        loadNextPageMovies();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadNextPageMovies() async {
    if (isLastPage || isLoadingPage) return;
    if (widget.loadNextPage == null) return;
    isLoadingPage = true;
    final newMovies = await widget.loadNextPage!();
    isLoadingPage = false;

    if (newMovies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }
          final movie = widget.movies[index];
          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}
