import 'package:cinema_app_03/presentation/screens/screens.dart';
import 'package:cinema_app_03/presentation/views/home_views/favorites_view.dart';
import 'package:cinema_app_03/presentation/views/home_views/home_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (_, __, child) => HomeScreen(childView: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => HomeView(),
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (_, __) {
                final movieId = __.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            ),
          ],
        ),

        GoRoute(
          path: '/favorites',
          name: FavoritesView.name,
          builder: (_, __) => const FavoritesView(),
          routes: [],
        ),
      ],
    ),
  ],
);
