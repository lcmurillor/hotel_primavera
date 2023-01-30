import 'package:flutter/material.dart';

///Ésta clase se encarga de cargar el valor del formulario de busqueda de clientes.
class SearchFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String info = '';

  ///Valida si el formulario cumple con las condiciones mínimas para hacer una busqueda.
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
