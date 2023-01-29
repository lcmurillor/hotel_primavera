import 'package:flutter/material.dart';

class MainLayoutPage extends StatelessWidget {
  ///Este es el contenedor principal que es utilizado para alojar todas las vistas que se
  ///muestran en la aplicación. Será  útil para genera run diseño responsivo.
  ///Los "child" son las diferentes vistas.
  const MainLayoutPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [child],
      ),
    );
  }
}
