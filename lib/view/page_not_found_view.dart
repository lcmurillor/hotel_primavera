import 'package:flutter/material.dart';
import '../themes/themes.dart';

class PageNotFoundView extends StatelessWidget {
  ///Esta es la página que se muestra cuando el enrutamiento de la aplicación es
  ///erroneo o no se encuetra disponible.
  const PageNotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            color: ColorStyle.mainIceBlue,
            width: size.width,
            height: size.height,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text('Error: 404 Página no encontrada',
                      style: CustomTextStyle.robotoSemiBold.copyWith(
                          fontSize: 60, color: ColorStyle.mainDarkGreen)),
                  Text('Por favor, vuelva a la página principal.',
                      style: CustomTextStyle.robotoMedium.copyWith(
                          fontSize: 20, color: ColorStyle.mainSoftGreen))
                ]))));
  }
}
