import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_primavera_app/services/services.dart';
import '../providers/providers.dart';
import '../themes/themes.dart';
import '../widgets/widgets.dart';

class MainLayoutPage extends StatelessWidget {
  ///Este es el contenedor principal que es utilizado para alojar todas las vistas que se
  ///muestran en la aplicación. Será  útil para genera run diseño responsivo.
  ///Los "child" son las diferentes vistas.
  const MainLayoutPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => SearchFormProvider(),
      child: Builder(builder: (context) {
        final searchFormProvider =
            Provider.of<SearchFormProvider>(context, listen: false);
        return Scaffold(
          ///Este elemento corresponde a la barra personalizada de la aplicación.
          appBar: _customAppBar(size, searchFormProvider, context),

          ///Este elemento coresponde al contenido de la página.
          body: Column(
            children: [child],
          ),
        );
      }),
    );
  }

  ///Barra superior personalizada para la aplicación. Con logo, barra de busqueda
  ///y bottones de acción respectivamente.
  PreferredSize _customAppBar(
      Size size, SearchFormProvider searchFormProvider, BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Row(children: [
          ///Imagen con el logo del Hotel Primavera.
          Container(
              width: size.width * 0.20,
              // height: size.height,
              color: ColorStyle.mainIceBlue,
              child: Center(
                  child: SvgPicture.asset('assets/logo.svg',
                      semanticsLabel: 'Logo Hotel Primavera',
                      fit: BoxFit.contain,
                      width: 250))),

          ///Input correspondiente a la barra de busqueda en la parte superior para
          ///buscar clientes.
          SizedBox(
              width: size.width * 0.50,
              child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Form(
                      key: searchFormProvider.formKey,
                      child: CustomTextInput(
                          height: 0,
                          label: 'Buscar cliente',
                          icon: Icons.search,
                          onChanged: (value) => searchFormProvider.info = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'No ha ingresado nungun dato de busqueda.';
                            } else {
                              return null;
                            }
                          })))),

          ///Este es el botón de la barra superiór el cual acciona la busqueda.
          Padding(
              padding: const EdgeInsets.only(
                  left: 22, right: 22, top: 22, bottom: 30),
              child: PrimaryButton(
                  text: "Buscar",
                  onPressed: () {
                    print("Buscar");
                  })),

          ///Este es el botón de la barra superiór el cual permite cerrar sesión.
          ///para esto muestra un mensaje primeramente para aegurar al usuario que
          ///se va a salir y si se confirma, se cierra la sesión.
          Padding(
            padding:
                const EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 30),
            child: PrimaryButton(
                color: ColorStyle.errorRed,
                width: size.width * 0.05,
                text: "Salir",

                ///Hace llamado al modal para informar al usuario que se cerrá la sesión.
                onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                          elevation: 10,
                          title: Text("Cerrar Sesión",
                              style: CustomTextStyle.robotoExtraBold
                                  .copyWith(fontSize: 35),
                              textAlign: TextAlign.center),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          content:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                                "¿Está seguro que desa cerrar la sesión actual?",
                                style: CustomTextStyle.robotoMedium,
                                textAlign: TextAlign.center)
                          ]),

                          ///Llama a las acciones (botones) para cerrar la sesión o continuar.
                          ///Se envia la función para cerrar la sesión.
                          actions: _actions(context,
                              () => FirebaseAuthService.signOut(context)));
                    })),
          )
        ]));
  }
}

///Esta lista corresponde a los dos botones que se encuentran en la parte inferior del cuadro de dialogo.
List<Widget> _actions(BuildContext context, void Function()? onPressed) {
  return [
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Aceptar',
            style: TextStyle(color: ColorStyle.mainGreen),
          )),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 20),
      child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(color: ColorStyle.errorRed),
          )),
    ),
  ];
}
