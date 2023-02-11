import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/services.dart';
import '../themes/themes.dart';
import '../widgets/widgets.dart';

class AddClinetCard {
  static displayAddClinetCard(
      {required BuildContext context, void Function()? onPressed}) {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 10,
              title: Text("Agregar Cliente",
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 35),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: SizedBox(
                  height: size.height * 0.50,
                  width: size.width * 0.70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Nombre comple del cliente',
                                  icon: Icons.account_circle_outlined,
                                  onChanged: (p0) {})),
                          Row(children: [
                            SizedBox(
                              height: 63,
                              width: 300,
                              child: DropdownButtonFormField<int>(
                                value:
                                    1, //Este será el valor por defecto al dibujar el widget
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Cédula de identidad',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      'Persona Jurídica',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text(
                                      'Pasaporte',
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  // registerFormProvider.identificationType =
                                  value ?? 1;
                                },
                              ),
                            ),
                            SizedBox(
                                height: 63,
                                width: 300,
                                child: CustomTextInput(
                                    label: 'Cédula',
                                    icon: Icons.credit_card_outlined,
                                    onChanged: (p0) {}))
                          ]),
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Correo electrónico principal',
                                  icon: Icons.email_outlined,
                                  onChanged: (p0) {})),
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Correo electrónico secundario',
                                  icon: Icons.email_outlined,
                                  onChanged: (p0) {})),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('not_image.png')))
                            ])
                      ])),

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
