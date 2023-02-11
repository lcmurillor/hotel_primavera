import 'package:flutter/material.dart';
import 'package:hotel_primavera_app/themes/themes.dart';

///Esta clase permite gestionar de manera controlada los diferentes tipos de cuadros de dialogo que son
///usados por la aplicación para dar información o advertir al usuario.
class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ///Este widget corresponde a un mensaje que se muestra en la parte inferir del dispositivo
  ///en caso de errores o para indicar un comportamineto no deseado de la aplicación o acciones del
  ///usuario.
  static showErrorSnackbar(String message) async {
    final snackBar = SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: CustomTextStyle.robotoMedium
                .copyWith(fontSize: 20, color: Colors.white)),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorStyle.errorRed,
        margin: const EdgeInsets.only(left: 500, right: 500, bottom: 30),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  ///Este widget corresponde a un mensaje que se muestra en la parte inferir del dispositivo
  ///para mostrar mensaje que no corresponden a ningun error y darle información al usuario
  ///respecto al comportamiento de la aplicación.
  static showSnackbar(String message) async {
    final snackBar = SnackBar(
        content: Text(message,
            textAlign: TextAlign.center,
            style: CustomTextStyle.robotoMedium
                .copyWith(fontSize: 20, color: Colors.white)),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorStyle.mainGreen,
        margin: const EdgeInsets.only(left: 500, right: 500, bottom: 30),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)));
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
