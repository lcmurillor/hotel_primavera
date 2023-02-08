import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar el valor del formulario de recuperación de contraseña
///y validar que cumpla con los requerimientos mínimos.
class ChangePasswordFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';

  ///Valida si el formulario cumple con las condiciones mínimas para iniciar al sesión de un usuario.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
