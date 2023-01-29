import 'package:flutter/material.dart';
import '../themes/themes.dart';

class PrimaryButton extends StatelessWidget {
  ///Corresponde al botón principal que es utilizado en muchas de las ventanas de la aplicación
  ///como ación primaria. esto permite tener un estilo omogeneo en toda la aplicación.
  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.fontSize = 18,
      this.color})
      : super(key: key);
  final String text;
  final void Function()? onPressed;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: ColorStyle.mainSoftGreen,
        onPressed: onPressed,
        child: SizedBox(
          width: size.width * 0.17,
          height: size.height * 0.08,
          child: Center(
            child: Text(text,
                style: CustomTextStyle.robotoMedium
                    .copyWith(fontSize: fontSize, color: Colors.white)),
          ),
        ));
  }
}
