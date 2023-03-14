// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../providers/providers.dart';
import '../services/services.dart';
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
          final newClientFormProvider =
              Provider.of<NewClientFormProvider>(context, listen: false);
          return AlertDialog(
              elevation: 10,
              title: Text("Agregar Cliente",
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 40),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),

              ///Este es el llamado al formulario el cual se carga con la información
              ///del cliente que se deseea agregar.
              content:
                  _NewClientForm(newClientFormProvider: newClientFormProvider),

              ///Llama a las acciones (botones) para cerrar la sesión o continuar.
              ///Se envia la función para cerrar la sesión.
              actions: _actions(
                  context,
                  () => _validate(
                      newClientFormProvider: newClientFormProvider,
                      context: context)));
        });
  }

  ///Esta lista corresponde a los dos botones que se encuentran en la parte inferior del cuadro de dialogo.
  static List<Widget> _actions(
      BuildContext context, void Function()? onPressed) {
    final size = MediaQuery.of(context).size;
    return [
      Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: PrimaryButton(
              width: size.width * 0.15,
              height: size.height * 0.07,
              text: 'Guardar nuevo cliente',
              onPressed: onPressed)),
      Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 10),
          child: PrimaryButton(
              width: size.width * 0.15,
              height: size.height * 0.07,
              text: 'Cancelar',
              onPressed: () {
                final clientImageProvider =
                    Provider.of<ClientImageProvider>(context, listen: false);
                clientImageProvider.setDefaultImage();
                Navigator.pop(context);
              },
              color: ColorStyle.errorRed))
    ];
  }
}

class _NewClientForm extends StatefulWidget {
  ///Este elemento contiene toda la lógica de construción de un formulario y llenado
  ///para generar un nuevo cliente en el sistema.
  const _NewClientForm({required this.newClientFormProvider});

  final NewClientFormProvider newClientFormProvider;

  @override
  State<_NewClientForm> createState() => _NewClientFormState();
}

class _NewClientFormState extends State<_NewClientForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clientImageProvider =
        Provider.of<ClientImageProvider>(context, listen: true);
    return Form(
      key: widget.newClientFormProvider.formKey,
      child: SizedBox(
          height: size.height * 0.60,
          width: size.width * 0.60,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(children: [
              ///ESTE ES EL CONTENEDOR DE NOMBRE CLIENTE
              SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      height: 0,
                      label: 'Nombre completo del cliente',
                      icon: Icons.account_circle_outlined,
                      onChanged: (value) =>
                          widget.newClientFormProvider.name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Debe ingresar el nombre del cliente.';
                        }
                        return null;
                      })),

              ///ESTE ES EL CONTENEDOR DE DEL TIPO Y LA CEDULA
              Container(
                  alignment: Alignment.center,
                  height: size.height * 0.10,
                  width: size.width * 0.40,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: size.height * 0.10,
                            width: size.width * 0.19,
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
                                      value: 3,
                                      child: Text('Cédula extranjero')),
                                  DropdownMenuItem(
                                      value: 4, child: Text('Pasaporte')),
                                ],
                                onChanged: (value) => widget
                                    .newClientFormProvider
                                    .identificationType = value!)),
                        SizedBox(
                            height: size.height * 0.10,
                            width: size.width * 0.19,
                            child: CustomTextInput(
                                height: 0,
                                label: 'Cédula',
                                icon: Icons.credit_card_outlined,
                                onChanged: (value) => widget
                                    .newClientFormProvider
                                    .identification = value,

                                ///LLamado al método que hace las validaciones de las diferentes
                                ///cédulas que se puede ingresar al sistema.
                                validator: (value) =>
                                    _validedIdentificantionCondition(
                                        value: value!,
                                        identificationType: widget
                                            .newClientFormProvider
                                            .identificationType)))
                      ])),

              ///ESTE ES EL CONTENEDOR DEL CORREO PRINCIPAL
              SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      height: 0,
                      label: 'Correo electrónico principal',
                      icon: Icons.email_outlined,
                      onChanged: (value) =>
                          widget.newClientFormProvider.email1 = value,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Debe ingresar un correo elecrónico para crear el cliente.';
                        if (!EmailValidator.validate(value))
                          return 'El correo elecrónico no es válido.';
                        else
                          return null;
                      })),

              ///ESTE ES EL CONTENEDOR DEL CORREO SECUNDARIO
              SizedBox(
                  height: size.height * 0.10,
                  width: size.width * 0.40,
                  child: CustomTextInput(
                      height: 0,
                      label: 'Correo electrónico secundario',
                      icon: Icons.email_outlined,
                      onChanged: (value) =>
                          widget.newClientFormProvider.email2 = value)),

              ///ESTE ES EL CONTENEDOR DE LA EMPREZA Y LA CEDULA
              SizedBox(
                  width: size.width * 0.40,
                  height: size.height * 0.10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: size.height * 0.10,
                            width: size.width * 0.19,
                            child: CustomTextInput(
                                height: 0,
                                label: 'Empresa',
                                icon: Icons.business_center_outlined,
                                onChanged: (value) => widget
                                    .newClientFormProvider.enterprise = value)),
                        SizedBox(
                            height: size.height * 0.10,
                            width: size.width * 0.19,
                            child: CustomTextInput(
                                height: 0,
                                label: 'Cédula jirídica',
                                icon: Icons.credit_card_outlined,
                                onChanged: (value) => widget
                                    .newClientFormProvider
                                    .enterpriseIdentification = value))
                      ])),

              ///ESTE ES EL CONTENEDOR DE LOS DOS NUMEROS DE TELEFONO
              SizedBox(
                  width: size.width * 0.40,
                  height: size.height * 0.10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO PRINCIPAL
                        SizedBox(
                            height: size.height * 0.10,
                            width: size.width * 0.19,
                            child: CustomTextInput(
                                height: 0,
                                label: 'Número de teléfono principal',
                                icon: Icons.phone_iphone_outlined,
                                onChanged: (value) => widget
                                    .newClientFormProvider
                                    .number1 = int.parse(value),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Debe ingresar un número de teléfono para crear el cliente.';
                                  return null;
                                })),

                        ///ESTE ES EL CONTENEDOR DEL NUMERO DE TELEFONO SECUNDARIO
                        SizedBox(
                            height: size.height * 0.10,
                            width: size.width * 0.19,
                            child: CustomTextInput(
                                height: 0,
                                label: 'Número de teléfono secundario',
                                icon: Icons.phone_iphone_outlined,
                                onChanged: (value) => widget
                                    .newClientFormProvider
                                    .number2 = int.parse(value)))
                      ]))
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: MemoryImage(clientImageProvider.image))),
              SizedBox(
                  height: size.height * 0.12,
                  width: 200,
                  child: SecundaryButton(
                      text: 'Agregar imagen',
                      onPressed: () =>
                          _addImage(clientImageProvider: clientImageProvider))),
            ])
          ])),
    );
  }
}

void _validate(
    {required NewClientFormProvider newClientFormProvider,
    required BuildContext context}) {
  if (newClientFormProvider.validateForm()) {
    // FirebaseDatabaseService.getUserByEmail(
    //         email: loginFormProvider.email, isFromPassword: true)
    //     .then((User? user) => _validateData(
    //         user: user,
    //         loginFormProvider: loginFormProvider,
    //         context: context));
  } else {
    // NotificationsService.showErrorSnackbar(
    //     'No se han ingresado los datos para iniciar sesión.');
  }
}

///Se Valida según el tipo de identificación y los valores ingresados que cumpla un
///lineamiento mínimo y si es así returna nulo, y no es necesario indicarle el error
///al usuario.
String? _validedIdentificantionCondition(
    {required String value, required int identificationType}) {
  if (identificationType == 1 && (value == null || value.isEmpty)) {
    return 'Debe ingresar una cédula de identidad nacional para crear el cliente.';
  } else if (identificationType == 1 && value.length != 9) {
    return 'La cédula de identidad nacional no comple con la logitud adecuada.';
  } else if (identificationType == 2 && (value == null || value.isEmpty)) {
    return 'Debe ingresar una cédula jurídica para crear el cliente.';
  } else if (identificationType == 2 &&
      (value.length != 10 || value.substring(0, 1) != '3')) {
    return 'La cédula jurídica no comple con la los requemientos correspondientes.';
  } else if (identificationType == 3 && (value == null || value.isEmpty)) {
    return 'Debe ingresar una cédula de identidad extranjero para crear el cliente.';
  } else if (identificationType == 4 && (value == null || value.isEmpty)) {
    return 'Debe ingresar una pasaporte para crear el cliente.';
  }
  return null;
}

///Esta función permite cargar una imagen previa del cliente en el formulario para
///ingresar los datos respectivos.
_addImage({required ClientImageProvider clientImageProvider}) async {
  final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg']);

  if (result == null) {
    NotificationsService.showSnackbar('No ha selecionado ninguna imagen.');
  } else {
    Uint8List? fileBytes = result.files.first.bytes;
    clientImageProvider.setImage(image: fileBytes!);
  }
}
