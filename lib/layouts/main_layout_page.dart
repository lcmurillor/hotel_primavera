import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
          appBar: PreferredSize(
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

                ///Input correspondiente al correo electronico solicitado para iniciar sesión.
                SizedBox(
                  child: Form(
                    key: searchFormProvider.formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomTextInput(
                            height: 20,
                            label: 'Correo Electrónico',
                            icon: Icons.email,
                            onChanged: (value) =>
                                searchFormProvider.info = value,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'No ha ingresado nungun dato de busqueda.';
                              } else {
                                return null;
                              }
                            })),
                  ),
                ),
              ])),
          body: Column(
            children: [child],
          ),
        );
      }),
    );
  }
}

// @override
// Size get preferredSize => const Size.fromHeight(kToolbarHeight);

///Éste método se encarga de la construcción del estilo de la barra de busqueda
InputDecoration inputDecoration() {
  return InputDecoration(
      prefixStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      hintText: 'Busca un Producto',
      hintStyle: GoogleFonts.roboto(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      prefixIcon: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            'assets/search.svg',
            fit: BoxFit.contain,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent)));
}
