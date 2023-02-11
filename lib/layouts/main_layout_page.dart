import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final double padding = size.width * 0.01;
    return ChangeNotifierProvider(
      create: (_) => SearchFormProvider(),
      child: Builder(builder: (context) {
        final searchFormProvider =
            Provider.of<SearchFormProvider>(context, listen: false);
        return Scaffold(
          ///Este elemento corresponde a la barra personalizada de la aplicación.
          appBar: _customAppBar(size, searchFormProvider, context, padding),

          ///Este elemento coresponde al contenido de la página.
          body: Column(
            children: [child],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  AddClinetCard.displayAddClinetCard(context: context),
              backgroundColor: ColorStyle.mainGreen,
              child: const Icon(Icons.group_add_outlined)),
        );
      }),
    );
  }
}

///Barra superior personalizada para la aplicación. Con logo, barra de busqueda
///y bottones de acción respectivamente.
PreferredSize _customAppBar(Size size, SearchFormProvider searchFormProvider,
    BuildContext context, double padding) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 0), blurRadius: 15)
          ], color: Colors.white),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Imagen con el logo del Hotel Primavera.
                Container(
                    color: ColorStyle.mainIceBlue,
                    width: size.width * 0.20,
                    child: Center(
                        child: SvgPicture.asset('assets/logo.svg',
                            semanticsLabel: 'Logo Hotel Primavera',
                            fit: BoxFit.contain,
                            width: 250))),

                ///Input correspondiente a la barra de busqueda en la parte superior para
                ///buscar clientes.
                SizedBox(
                    width: size.width * 0.40,
                    height: 100,
                    child: Form(
                        key: searchFormProvider.formKey,
                        child: CustomTextInput(
                            height: 0,
                            label: 'Buscar cliente',
                            icon: Icons.search,
                            onChanged: (value) =>
                                searchFormProvider.info = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'No ha ingresado nungun dato de busqueda.';
                              } else {
                                return null;
                              }
                            }))),

                ///Este es el botón de la barra superiór el cual acciona la busqueda.
                PrimaryButton(
                    height: 48,
                    text: 'Buscar',
                    onPressed: () {
                      print('Buscar');
                    }),

                SizedBox(width: size.width * 0.10),

                ///Este es el botón de la barra superiór el cual permite cerrar sesión.
                ///para esto muestra un mensaje primeramente para aegurar al usuario que
                ///se va a salir y si se confirma, se cierra la sesión.
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: MaterialButton(
                        color: ColorStyle.errorRed,
                        height: 56,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),

                        ///Hace llamado al modal para informar al usuario que se cerrá la sesión.
                        onPressed: () =>
                            SignOutCard.displaySignOutCard(context: context),
                        child: const Icon(Icons.output_outlined,
                            color: Colors.white)))
              ])));
}
