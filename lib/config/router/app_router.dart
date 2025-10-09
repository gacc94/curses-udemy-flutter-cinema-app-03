import 'package:cinema_app_03/presentation/screens/screens.dart';
import 'package:cinema_app_03/presentation/views/home_views/favorites_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: <RouteBase>[
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        //* Child Routes
        GoRoute(
          path: '/movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        ),

        GoRoute(
          path: 'favorites',
          name: FavoritesView.name,
          builder: (context, state) => const FavoritesView(),
          routes: [],
        ),
      ],
    ),

    GoRoute(path: '/', redirect: (_, __) => '/home/0'),
  ],
);

// final GoRouter appRouter = GoRouter(
//   initialLocation: '/',
//   routes: [
//     ShellRoute(
//       builder: (_, __, child) => HomeScreen(childView: child),
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (_, __) => HomeView(),
//           routes: [
//             GoRoute(
//               path: 'movie/:id',
//               name: MovieScreen.name,
//               builder: (_, __) {
//                 final movieId = __.pathParameters['id'] ?? 'no-id';
//                 return MovieScreen(movieId: movieId);
//               },
//             ),
//           ],
//         ),

//         GoRoute(
//           path: '/favorites',
//           name: FavoritesView.name,
//           builder: (_, __) => const FavoritesView(),
//           routes: [],
//         ),
//       ],
//     ),
//   ],
// );
