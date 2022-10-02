import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_primavera_app/shared/shareds.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * 0.50,
          height: size.height,
          color: const Color.fromRGBO(227, 246, 252, 1),
          child: Center(
            child: SvgPicture.asset('logo.svg',
                semanticsLabel: 'Logo Hotel Primavera',
                fit: BoxFit.cover,
                width: 500),
          ),
        ),
        SizedBox(
          width: size.width * 0.50,
          height: size.height,
          child: const Center(child: LoginCard()),
        )
      ],
    );
  }
}
