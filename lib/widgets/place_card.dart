import 'package:flutter/material.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';

class PlaceCard extends StatelessWidget {
  final bool isChoose;
  final String label, image;
  final VoidCallback callback;
  const PlaceCard(
      {super.key,
      this.isChoose = false,
      required this.label,
      required this.callback,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Card(
          color: isChoose ? primaryColor : greyColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Image.asset(image, width: 75),
                Helpers.getVerticalSpacer(2),
                Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: isChoose ? Colors.white : textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
