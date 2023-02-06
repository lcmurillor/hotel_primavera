import '../models/models.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../themes/themes.dart';
import '../widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  ///Este elemento corresponde al card que se encuentra en la vista principal del de la aplicación donde el usuario
  ///ingresa los datos para acceder. Por los datos sensibles que cuarda la aplicación es requerido un sistema de
  ///autentificación robusto.
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),

      ///Contenedor principal que le da la forma base al dormulario.
      child: Card(
          child: SizedBox(
        width: size.width * 0.30,
        height: size.height * 0.65,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              "Iniciar Sesión",
              style: CustomTextStyle.robotoSemiBold
                  .copyWith(fontSize: 50, color: ColorStyle.mainDarkGreen),
            ),
            const SizedBox(height: 50),
            const _LoginForm()
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  ///En este  elemento se encuentra toda la lógica del formulario (los espacios en el cual
  ///el usuario ingresa los datos para iniciar sesión).
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormProvider =
        Provider.of<LoginFormProvider>(context, listen: false);
    return Form(
        key: loginFormProvider.formKey,
        child: Column(children: [
          ///Input correspondiente al correo electronico solicitado para iniciar sesión.
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextInput(
                  height: 20,
                  label: 'Correo Electrónico',
                  icon: Icons.email,
                  onChanged: (value) => loginFormProvider.email = value,
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

          ///Input correspondiente a la contraseña solicitado para iniciar sesión.
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextInput(
                  height: 20,
                  label: 'Contraseña',
                  icon: Icons.lock,
                  obscureText: true,
                  onChanged: (value) => loginFormProvider.password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su Contraseña.';
                    }
                    if (value.length < 6) {
                      return 'Debe tener más de 6 caractéres.';
                    }
                    return null;
                  })),
          PrimaryButton(
              text: 'Iniciar sesión',
              onPressed: () => _validate(
                  loginFormProvider: loginFormProvider, context: context)),
          const SizedBox(height: 10),
          SecundaryButton(
              text: '¿Olvidaste tu contraseña?',
              fontSize: 16,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'passwordRequest');
              })
        ]));
  }
}

///Función intermedia que hace una llamado a la base de datos para obtener un usuario
///si éste está registrado, de ahí se hacen el resto de evaluaciones de autetificación.
void _validate(
    {required LoginFormProvider loginFormProvider,
    required BuildContext context}) {
  if (loginFormProvider.validateForm()) {
    FirebaseDatabaseService.getUserByEmail(email: loginFormProvider.email).then(
        (User? user) => _validateData(
            user: user,
            loginFormProvider: loginFormProvider,
            context: context));
  } else {
    NotificationsService.showErrorSnackbar(
        'No se han ingresado los datos para iniciar sesión.');
  }
}

///Función de evalución final, evalua que el formulario cumpla con los requerimientos
///mínimos y si el usuario registrado está activo en el sistema. Si se cumplen las condiciones
///se puede iniciar la sesión.
void _validateData(
    {required User? user,
    required LoginFormProvider loginFormProvider,
    required BuildContext context}) {
  if (user != null && !user.disabled) {
    FirebaseAuthService.signIn(
        email: loginFormProvider.email,
        password: loginFormProvider.password,
        context: context);
  } else {
    NotificationsService.showErrorSnackbar(
        'El usuario indicado no está registrado.');
  }
}
