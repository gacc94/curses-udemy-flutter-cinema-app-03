import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const String name = 'favorites_view';
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: const Center(child: Text('Favorites View')),
    );
  }
}
