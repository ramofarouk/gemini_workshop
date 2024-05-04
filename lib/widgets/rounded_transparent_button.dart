import 'package:flutter/material.dart';
import 'package:gemini_game/themes/colors.dart';

class RoundedTransparentButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  const RoundedTransparentButton(
      {super.key, required this.label, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(25))),
        onPressed: callback,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(label,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))));
  }
}
