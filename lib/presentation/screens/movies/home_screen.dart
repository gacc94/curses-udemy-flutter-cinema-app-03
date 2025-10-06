import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: const Drawer(child: Center(child: Text('Drawer'))),
      appBar: AppBar(
        title: const Text(
          'Cinema App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Screen', style: theme.textTheme.headlineLarge),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/movie/1');
              },
              child: const Text('Movie'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.dark_mode_outlined),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {},
        currentIndex: 0,
        backgroundColor: theme.colorScheme.primary,
        selectedItemColor: theme.colorScheme.onPrimary,
        unselectedItemColor: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
