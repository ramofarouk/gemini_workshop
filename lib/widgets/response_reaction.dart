import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';

class ResponseReaction extends StatelessWidget {
  final bool isTrue;
  final int note;
  const ResponseReaction({super.key, required this.isTrue, this.note = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isTrue ? "assets/happy.png" : "assets/sad.png",
          width: 100,
        ),
        Helpers.getHorizontalSpacer(1),
        Text(
          isTrue ? "Good job guy!" : "Désolé, ce n'est pas ça!",
          style: const TextStyle(fontSize: 20),
        ),
        Helpers.getHorizontalSpacer(2),
        Visibility(
          visible: isTrue,
          child: Text(
            "+$note",
            style: const TextStyle(
                fontSize: 35, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
