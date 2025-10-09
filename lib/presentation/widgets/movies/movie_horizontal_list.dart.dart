import 'package:animate_do/animate_do.dart';
import 'package:cinema_app_03/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalList extends StatefulWidget {
  final List<Movie> movies;
  final String? subtitle;
  final String? title;
  final VoidCallback? loadNextPage;

  const MovieHorizontalList({
    super.key,
    required this.movies,
    this.subtitle,
    this.title,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalList> createState() => _MovieHorizontalListState();
}

class _MovieHorizontalListState extends State<MovieHorizontalList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.loadNextPage == null) return;
    if ((_scrollController.position.pixels + 200) >=
        _scrollController.position.maxScrollExtent) {
      widget.loadNextPage!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          //* Title Header
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          //* ListView
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              // physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return FadeInRight(
                  duration: const Duration(milliseconds: 300),
                  child: _Slide(movie: movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                height: 230,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return GestureDetector(
                      onTap: () {
                        context.push('/home/0/movie/${movie.id}');
                      },
                      child: FadeIn(child: child),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //*Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall,
            ),
          ),

          const SizedBox(height: 5),

          //*Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(Icons.star_half_outlined, color: Colors.amber),
                const SizedBox(width: 3.5),
                Text(
                  HumanFormats.numberDecimal(movie.voteAverage),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.amber,
                  ),
                ),

                const Spacer(),

                Text(
                  HumanFormats.number(movie.popularity),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//*TITLE
class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleLarge),

          const Spacer(flex: 1),

          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}
