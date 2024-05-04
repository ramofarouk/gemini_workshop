import 'package:flutter/material.dart';
import 'package:gemini_game/themes/colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 70,
        backgroundColor: secondaryColor,
        child: Image.asset("assets/logo.png", width: 80));
  }
}
