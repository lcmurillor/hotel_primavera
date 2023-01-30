import 'package:flutter/material.dart';

class LoginLayoutPage extends StatelessWidget {
  ///Este es el contenedor principal que contiene la vista de inicio de sesión.
  ///Los "child" son las diferentes vistas.
  const LoginLayoutPage({Key? key, required this.child}) : super(key: key);
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
