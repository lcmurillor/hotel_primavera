// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hotel_primavera_app/routers/routers.dart';
import 'package:hotel_primavera_app/services/services.dart';
import 'package:hotel_primavera_app/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../themes/themes.dart';

class ChangePasswordCard extends StatelessWidget {
  ///Este elemento corresponde al card que se utiliza para que el ususario ingrese el correo y pueda
  ///solicitar un cambio de contraseña.
  const ChangePasswordCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordFormProvider(),

      ///Contenedor principal que le da la forma base al formulario.
      child: Card(
          child: SizedBox(
        width: size.width * 0.30,
        height: size.height * 0.65,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    textAlign: TextAlign.center,
                    "Solicitar cambio de contraseña",
                    style: CustomTextStyle.robotoSemiBold.copyWith(
                        fontSize: 40, color: ColorStyle.mainDarkGreen))),
            const _ChangePasswordForm()
            // const _LoginForm()
          ],
        ),
      )),
    );
  }
}

class _ChangePasswordForm extends StatelessWidget {
  ///Esta función se encarga de generar todo el formulario y hacer las
  ///respetivas validaciones para realizar la solicitud de cambio
  ///de contraseña para un ususario registrado.
  const _ChangePasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changePasswordFormProvider =
        Provider.of<ChangePasswordFormProvider>(context, listen: false);
    return Form(
      key: changePasswordFormProvider.formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(40.0),
              child: CustomTextInput(
                  height: 10,
                  label: 'Correo Electrónico',
                  icon: Icons.email,
                  onChanged: (value) =>
                      changePasswordFormProvider.email = value,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su Correo Elecrónico.';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'El Correo Elecrónico no es válido.';
                    } else {
                      return null;
                    }
                  })),
          PrimaryButton(
              text: "Solicitar cambio",
              onPressed: () => _validate(
                  changePasswordFormProvider: changePasswordFormProvider,
                  context: context)),
          const SizedBox(height: 10),
          SecundaryButton(
              text: "Regresar al inicio de sesión",
              onPressed: () =>
                  NavigationService.replaceTo(Flurorouter.rootRoute))
        ],
      ),
    );
  }
}

///Función intermedia que hace una llamado a la base de datos para obtener un usuario
///si éste está registrado, de ahí se hacen el resto de evaluaciones de autetificación.
void _validate(
    {required ChangePasswordFormProvider changePasswordFormProvider,
    required BuildContext context}) {
  if (changePasswordFormProvider.validateForm()) {
    FirebaseDatabaseService.getUserByEmail(
            email: changePasswordFormProvider.email, isFromPassword: true)
        .then((User? user) => _validateData(
            user: user,
            changePasswordFormProvider: changePasswordFormProvider,
            context: context));
  } else {
    NotificationsService.showErrorSnackbar(
        'No se han ingresado los datos para iniciar sesión.');
  }
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se le enviará un correo para que este cmabie la contraseña.
void _validateData(
    {required User? user,
    required ChangePasswordFormProvider changePasswordFormProvider,
    required BuildContext context}) async {
  if (user != null && !user.disabled) {
    if (!await FirebaseAuthService.requestPassword(
        email: changePasswordFormProvider.email, context: context)) {
      NotificationsService.showSnackbar(
          'Se ha enviado la solicitud de cambio a su correo electrónico ${changePasswordFormProvider.email}');
      NavigationService.replaceTo(Flurorouter.rootRoute);
    }
  } else {
    NotificationsService.showErrorSnackbar(
        'El usuario indicado no está registrado.');
  }
}
