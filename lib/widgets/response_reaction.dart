import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_game/providers/game.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';

class ResponseReaction extends StatelessWidget {
  const ResponseReaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final game = ref.watch(gameProvider);
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(game.isCorrect ? "assets/happy.png" : "assets/sad.png",
            width: 100),
        Helpers.getHorizontalSpacer(1),
        Text(game.isCorrect ? "Good job guy!" : "Désolé, ce n'est pas ça!",
            style: const TextStyle(fontSize: 20)),
        Helpers.getHorizontalSpacer(2),
        Visibility(
            visible: game.isCorrect,
            child: Text("+${game.noteToAdd}",
                style: const TextStyle(
                    fontSize: 35,
                    color: primaryColor,
                    fontWeight: FontWeight.bold)))
      ]);
    });
  }
}
