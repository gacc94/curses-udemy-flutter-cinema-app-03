import 'package:cinema_app_03/presentation/views/views.dart';
import 'package:cinema_app_03/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  final int pageIndex;
  final List<Widget> views = <Widget>[
    HomeView(),
    FavoritesView(),
    SizedBox(), //*Categories
  ];

  HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: views,
      ), //* Intentar con PAGEVIEW PARA SLIDE DE PAGES COMO TUTORIAL PERO AMNTENIENDO EL BOTTOMNAVIGATION
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
