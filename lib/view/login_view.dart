import '../themes/themes.dart';
import '../widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  ///Esta vista es la pantalla principal donde el ususario inicia sesión en la aplicación.
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        ///Imagen con el logo del Hotel Primavera.
        Container(
          width: size.width * 0.50,
          height: size.height,
          color: ColorStyle.mainIceBlue,
          child: Center(
            child: SvgPicture.asset('assets/logo.svg',
                semanticsLabel: 'Logo Hotel Primavera',
                fit: BoxFit.cover,
                width: 500),
          ),
        ),

        ///Espacio para el contenedor donde se encuentra el card de login.
        SizedBox(
          width: size.width * 0.50,
          height: size.height,
          child: const Center(child: LoginCard()),
        )
      ],
    );
  }
}
