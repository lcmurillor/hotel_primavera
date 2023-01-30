import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/themes.dart';

///Este es el apartado general que le da el estilo a todos los text inputs de la aplicación.
class InputStyle {
  static InputDecoration mainInput(
      {required String label, required IconData icon}) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.9, horizontal: 15),
      prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColorStyle.mainDarkGreen),
            child: Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
          )),
      label: Text(label),
      labelStyle: TextStyle(color: ColorStyle.mainSoftGreen),
      hintStyle: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[500]),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorStyle.mainDarkGreen)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorStyle.mainSoftGreen)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorStyle.errorRed)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorStyle.errorRed)),
    );
  }
}
