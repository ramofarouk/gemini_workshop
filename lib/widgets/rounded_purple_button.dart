import 'package:flutter/material.dart';
import 'package:gemini_game/themes/colors.dart';

class RoundedPurpleButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final double radius;
  const RoundedPurpleButton(
      {super.key,
      required this.label,
      required this.callback,
      this.radius = 25});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        onPressed: callback,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(label,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold))));
  }
}
