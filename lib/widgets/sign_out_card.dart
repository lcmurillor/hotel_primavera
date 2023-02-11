import 'package:flutter/material.dart';

import '../services/services.dart';
import '../themes/themes.dart';

class SignOutCard {
  static displaySignOutCard(
      {required BuildContext context, void Function()? onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 10,
              title: Text("¿Cerrar Sesión?",
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 35),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("¿Está seguro que desa cerrar la sesión actual?",
                    style: CustomTextStyle.robotoMedium,
                    textAlign: TextAlign.center)
              ]),

              ///Llama a las acciones (botones) para cerrar la sesión o continuar.
              ///Se envia la función para cerrar la sesión.
              actions: _actions(
                  context, () => FirebaseAuthService.signOut(context)));
        });
  }

  ///Esta lista corresponde a los dos botones que se encuentran en la parte inferior del cuadro de dialogo.
  static List<Widget> _actions(
      BuildContext context, void Function()? onPressed) {
    return [
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
              onPressed: onPressed,
              child: Text('Aceptar',
                  style: TextStyle(color: ColorStyle.mainGreen)))),
      Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: TextStyle(color: ColorStyle.errorRed))))
    ];
  }
}
