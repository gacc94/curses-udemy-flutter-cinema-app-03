import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> _getLoadingMessages() {
    final messages = [
      'Cargando películas...',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya casi papu',
      'Esto esta tardando más de lo esperado ;:C',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (event) {
      return messages[event];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 10),
          Text('Cargando películas...'),

          StreamBuilder(
            stream: _getLoadingMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return Text(snapshot.data!);
              return const SizedBox(child: Text('Cargando.....'));
            },
          ),
        ],
      ),
    );
  }
}
