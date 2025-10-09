import 'package:cinema_app_03/app.dart';
import 'package:cinema_app_03/config/database/database.dart';
// import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // await db
  // //     .into(db.favoriteMovies)
  // //     .insert(
  // //       FavoriteMoviesCompanion.insert(
  // //         movieId: 1,
  // //         backdropPath: 'backdropPath.png',
  // //         posterPath: 'posterPath.png',
  // //         originalTitle: 'Mi first Movie',
  // //         title: 'Mi first Movie',
  // //       ),
  // //     );

  final deleteQuery = db.delete(db.favoriteMovies);
  deleteQuery.go();

  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MainApp()));
}
