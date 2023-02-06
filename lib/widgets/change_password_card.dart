import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../themes/themes.dart';

class ChangePasswordCard extends StatelessWidget {
  ///Este elemento corresponde al card que se encuentra en la vista principal del de la aplicación donde el usuario
  ///ingresa los datos para acceder. Por los datos sensibles que cuarda la aplicación es requerido un sistema de
  ///autentificación robusto.
  const ChangePasswordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),

      ///Contenedor principal que le da la forma base al dormulario.
      child: Card(
          child: SizedBox(
        width: size.width * 0.30,
        height: size.height * 0.65,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              textAlign: TextAlign.center,
              "Solicitar cambio de contraseña",
              style: CustomTextStyle.robotoSemiBold
                  .copyWith(fontSize: 40, color: ColorStyle.mainDarkGreen),
            ),
            const SizedBox(height: 50),
            // const _LoginForm()
          ],
        ),
      )),
    );
  }
}
