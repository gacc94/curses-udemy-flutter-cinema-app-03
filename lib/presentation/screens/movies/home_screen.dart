import 'package:cinema_app_03/domain/entities/movie.dart';
import 'package:cinema_app_03/presentation/providers/providers.dart';
import 'package:cinema_app_03/presentation/widgets/movies/movie_horizontal_list.dart.dart';
import 'package:cinema_app_03/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({super.key});

  @override
  ConsumerState<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slides = ref.watch(moviesSlideShowProvider);

    return Visibility(
      visible: !initialLoading,
      child: _CustomScrollView(
        slides: slides,
        nowPlayingMovies: nowPlayingMovies,
        ref: ref,
        popularMovies: popularMovies,
        upcomingMovies: upcomingMovies,
        topRatedMovies: topRatedMovies,
      ),
    );
  }
}

class _CustomScrollView extends StatelessWidget {
  const _CustomScrollView({
    super.key,
    required this.slides,
    required this.nowPlayingMovies,
    required this.ref,
    required this.popularMovies,
    required this.upcomingMovies,
    required this.topRatedMovies,
  });

  final List<Movie> slides;
  final List<Movie> nowPlayingMovies;
  final WidgetRef ref;
  final List<Movie> popularMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              alignment: Alignment.center,
              child: const CustomAppBar(),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideShow(movies: slides.isNotEmpty ? slides : []),

                MovieHorizontalList(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subtitle: 'Estrenos',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                MovieHorizontalList(
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: 'Populares',
                  loadNextPage: () =>
                      ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalList(
                  movies: upcomingMovies,
                  title: 'Próximos',
                  subtitle: 'Próximos',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),

                MovieHorizontalList(
                  movies: topRatedMovies,
                  title: 'Mejor calificados',
                  subtitle: 'Mejor calificados',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
