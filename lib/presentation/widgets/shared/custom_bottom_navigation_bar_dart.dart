import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  // int getCurrentIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).uri.toString();
  //   if (location.contains('/favorites')) {
  //     return 1;
  //   } else if (location.contains('/categories')) {
  //     return 2;
  //   }
  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            context.go('/home/0');
            break;
          case 1:
            context.go('/home/1');
            break;
          case 2:
            context.go('/home/2');
            break;
        }
      },
      elevation: 1,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
      ],
    );
  }
}
