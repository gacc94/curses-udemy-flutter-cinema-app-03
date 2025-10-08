import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        // print(value);
      },
      elevation: 1,
      currentIndex: 0,
      // backgroundColor: Theme.of(context).colorScheme.primary,
      // selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      // unselectedItemColor: Theme.of(
      //   context,
      // ).colorScheme.onPrimary.withValues(alpha: 0.5),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
