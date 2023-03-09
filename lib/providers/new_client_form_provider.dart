import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar los valores de los formularios para registrar un nuevo cliente
///y validar que cumpla con los requerimientos mínimos.
class NewClientFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email1 = "";
  String email2 = "";
  String enterprise = "";
  String enterpriseIdentification = "";
  String identification = "";
  int identificationType = 0;
  String imageUrl = "";
  String name = "";
  int number1 = 0;
  int number2 = 0;

  ///Valida si el formulario cumple con las condiciones mínimas para registra el cliente.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
