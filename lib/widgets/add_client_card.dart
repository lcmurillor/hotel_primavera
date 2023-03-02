import 'package:flutter/material.dart';
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
                  height: size.height * 0.60,
                  width: size.width * 0.70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          ///ESTE ES EL CONTENEDOR DE NOMBRE CLIENTE
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Nombre comple del cliente',
                                  icon: Icons.account_circle_outlined,
                                  onChanged: (p0) {})),

                          ///ESTE ES EL CONTENEDOR DE DEL TIPO Y LA CEDULA
                          SizedBox(
                            height: 63,
                            width: 600,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 250,
                                    child: DropdownButtonFormField<int>(
                                      borderRadius: BorderRadius.circular(15),
                                      elevation: 0,
                                      decoration: InputStyle.mainInput(
                                          label: '',
                                          icon: Icons.perm_identity_outlined),
                                      value:
                                          1, //Este será el valor por defecto al dibujar el widget
                                      items: const [
                                        DropdownMenuItem(
                                            value: 1,
                                            child: Text('Cédula de identidad')),
                                        DropdownMenuItem(
                                            value: 2,
                                            child: Text('Persona Jurídica'))
                                      ],
                                      onChanged: (value) {
                                        // registerFormProvider.identificationType =
                                        value ?? 1;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      height: 63,
                                      width: 250,
                                      child: CustomTextInput(
                                          label: 'Cédula',
                                          icon: Icons.credit_card_outlined,
                                          onChanged: (p0) {}))
                                ]),
                          ),

                          ///ESTE ES EL CONTENEDOR DEL CORREO PRINCIPAL
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Correo electrónico principal',
                                  icon: Icons.email_outlined,
                                  onChanged: (p0) {})),

                          ///ESTE ES EL CONTENEDOR DEL CORREO SECUNDARIO
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Correo electrónico secundario',
                                  icon: Icons.email_outlined,
                                  onChanged: (p0) {})),

                          ///ESTE ES EL CONTENEDOR DE LA MEPREZA Y LA CEDULA
                          SizedBox(
                            width: 600,
                            height: 63,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      height: 63,
                                      width: 250,
                                      child: CustomTextInput(
                                          label: 'Empresa',
                                          icon: Icons.business_center_outlined,
                                          onChanged: (p0) {})),
                                  SizedBox(
                                      height: 63,
                                      width: 250,
                                      child: CustomTextInput(
                                          label: 'Cédula',
                                          icon: Icons.credit_card_outlined,
                                          onChanged: (p0) {})),
                                ]),
                          ),

                          ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO PRINCIPAL
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Número de teléfono principal',
                                  icon: Icons.phone_iphone_outlined,
                                  onChanged: (p0) {})),

                          ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO SECUNDARIO
                          SizedBox(
                              height: 63,
                              width: 600,
                              child: CustomTextInput(
                                  label: 'Número de teléfono secundario',
                                  icon: Icons.phone_iphone_outlined,
                                  onChanged: (p0) {})),
                        ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('not_image.png'))),
                              SizedBox(
                                  height: 63,
                                  width: 200,
                                  child: SecundaryButton(
                                      text: 'Agregar imagen',
                                      onPressed: () {})),
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
          padding: const EdgeInsets.only(right: 10, bottom: 20),
          child:
              PrimaryButton(text: 'Guardar nuevo cliente', onPressed: () {})),
      Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: PrimaryButton(
              text: 'Cancelar',
              onPressed: () => Navigator.pop(context),
              color: ColorStyle.errorRed))
    ];
  }
}
