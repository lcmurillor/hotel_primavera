// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'package:flutter/material.dart';
import '../providers/providers.dart';
import '../themes/themes.dart';
import '../widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';

class AddClinetCard {
  static displayAddClinetCard(
      {required BuildContext context, void Function()? onPressed}) {
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
              content: ChangeNotifierProvider(
                create: (_) => NewClientFormProvider(),

                ///Este es el llamado al formulario el cual se carga con la información
                ///del cliente que se deseea agregar.
                child: const _NewClientForm(),
              ),

              ///Llama a las acciones (botones) para cerrar la sesión o continuar.
              ///Se envia la función para cerrar la sesión.
              actions: _actions(context, () {}));
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

class _NewClientForm extends StatelessWidget {
  ///Este elemento contiene toda la lógica de construción de un formulario y llenado
  ///para generar un nuevo cliente en el sistema.
  const _NewClientForm();

  @override
  Widget build(BuildContext context) {
    final newClientFormProvider =
        Provider.of<NewClientFormProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Form(
      key: newClientFormProvider.formKey,
      child: SizedBox(
          height: size.height * 0.60,
          width: size.width * 0.70,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(children: [
              ///ESTE ES EL CONTENEDOR DE NOMBRE CLIENTE
              SizedBox(
                  height: 63,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      label: 'Nombre completo del cliente',
                      icon: Icons.account_circle_outlined,
                      onChanged: (value) => newClientFormProvider.name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Debe ingresar el nombre del cliente.';
                        }
                        return null;
                      })),

              ///ESTE ES EL CONTENEDOR DE DEL TIPO Y LA CEDULA
              SizedBox(
                height: 63,
                width: size.width * 0.40,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 50,
                          width: size.width * 0.18,
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
                                    value: 1, child: Text('Cédula nacional')),
                                DropdownMenuItem(
                                    value: 2, child: Text('Cédula jurídica')),
                                DropdownMenuItem(
                                    value: 3, child: Text('Cédula extranjero')),
                                DropdownMenuItem(
                                    value: 4, child: Text('Pasaporte')),
                              ],
                              onChanged: (value) => newClientFormProvider
                                  .identificationType = value ?? 1)),
                      SizedBox(
                          height: 63,
                          width: size.width * 0.18,
                          child: CustomTextInput(
                              label: 'Cédula',
                              icon: Icons.credit_card_outlined,
                              onChanged: (value) =>
                                  newClientFormProvider.identification = value,

                              ///LLamado al método que hace las validaciones de las diferentes
                              ///cédulas que se puede ingresar al sistema.
                              validator: (value) =>
                                  _validedIdentificantionCondition(
                                      value: value!,
                                      newClientFormProvider:
                                          newClientFormProvider)))
                    ]),
              ),

              ///ESTE ES EL CONTENEDOR DEL CORREO PRINCIPAL
              SizedBox(
                  height: 63,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      label: 'Correo electrónico principal',
                      icon: Icons.email_outlined,
                      onChanged: (value) =>
                          newClientFormProvider.email1 = value,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Debe ingresar un correo elecrónico para crear el cliente.';
                        if (!EmailValidator.validate(value))
                          return 'El Correo Elecrónico no es válido.';
                        else
                          return null;
                      })),

              ///ESTE ES EL CONTENEDOR DEL CORREO SECUNDARIO
              SizedBox(
                  height: 63,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      label: 'Correo electrónico secundario',
                      icon: Icons.email_outlined,
                      onChanged: (value) =>
                          newClientFormProvider.email2 = value,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Debe ingresar un correo elecrónico para crear el cliente.';
                        else if (!EmailValidator.validate(value))
                          return 'El Correo Elecrónico no es válido.';
                        return null;
                      })),

              ///ESTE ES EL CONTENEDOR DE LA MEPREZA Y LA CEDULA
              SizedBox(
                width: size.width * 0.40,
                height: 63,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 63,
                          width: size.width * 0.18,
                          child: CustomTextInput(
                              label: 'Empresa',
                              icon: Icons.business_center_outlined,
                              onChanged: (value) =>
                                  newClientFormProvider.enterprise = value)),
                      SizedBox(
                          height: 63,
                          width: size.width * 0.18,
                          child: CustomTextInput(
                              label: 'Cédula jirídica',
                              icon: Icons.credit_card_outlined,
                              onChanged: (value) => newClientFormProvider
                                  .enterpriseIdentification = value)),
                    ]),
              ),

              ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO PRINCIPAL
              SizedBox(
                  height: 63,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      label: 'Número de teléfono principal',
                      icon: Icons.phone_iphone_outlined,
                      onChanged: (value) =>
                          newClientFormProvider.number1 = int.parse(value),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Debe número de teléfono para crear el cliente.';
                        return null;
                      })),

              ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO SECUNDARIO
              SizedBox(
                  height: 63,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      label: 'Número de teléfono secundario',
                      icon: Icons.phone_iphone_outlined,
                      onChanged: (value) =>
                          newClientFormProvider.number2 = int.parse(value))),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                      backgroundImage: AssetImage('not_image.png'))),
              SizedBox(
                  height: 63,
                  width: 200,
                  child: SecundaryButton(
                      text: 'Agregar imagen', onPressed: () {})),
            ])
          ])),
    );
  }
}

///Se Valida según el tipo de identificación y los valores ingresados que cumpla un
///lineamiento mínimo y si es así returna nulo, y no es necesario indicarle el error
///al usuario.
String? _validedIdentificantionCondition(
    {required String value,
    required NewClientFormProvider newClientFormProvider}) {
  if ((newClientFormProvider.identificationType == 1) && value == null ||
      value.isEmpty)
    return 'Debe ingresar una cédula de identidad nacional para crear el cliente.';

  if ((newClientFormProvider.identificationType == 1) && value.length != 9)
    return 'La cédula de identidad nacional no comple con la logitud adecuada.';

  if ((newClientFormProvider.identificationType == 2) && value == null ||
      value.isEmpty)
    return 'Debe ingresar una cédula jurídica para crear el cliente.';

  if ((newClientFormProvider.identificationType == 2) && value.length != 10 ||
      value.substring(0, 1) != '3')
    return 'La cédula jurídica no comple con la los requemientos correspondientes.';

  if ((newClientFormProvider.identificationType == 3) && value == null ||
      value.isEmpty)
    return 'Debe ingresar una cédula de identidad extranjero para crear el cliente.';
  return null;
}
