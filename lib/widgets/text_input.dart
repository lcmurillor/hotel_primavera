import 'package:flutter/material.dart';

import '../themes/input_style.dart';

class CustomTextInput extends StatelessWidget {
  ///Corresponde a una istancia de un objeto de tipo TextFormField, personalizado
  ///para que todos los inputs tengan el mismo aspecto.
  const CustomTextInput(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onChanged,
      this.validator,
      this.autocorrect = false,
      this.controller,
      this.height = 15,
      this.keyboardType,
      this.obscureText = false,
      this.onFieldSubmitted,
      this.onTap,
      this.readOnly = false,
      this.maxLines = 1})
      : super(key: key);

  final bool autocorrect;
  final bool obscureText;
  final bool readOnly;
  final double height;
  final Function? onFieldSubmitted;
  final Function(String) onChanged;
  final IconData icon;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;

  final TextEditingController? controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            maxLines: maxLines,
            autocorrect: autocorrect,
            controller: controller,
            decoration: InputStyle.mainInput(label: label, icon: icon),
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            validator: validator,
          ),
          SizedBox(height: height)
        ]);
  }
}
