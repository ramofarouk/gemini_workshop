import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_game/pages/home.dart';
import 'package:gemini_game/providers/game.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';
import 'package:gemini_game/widgets/logo.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';

class AfterGamePage extends StatelessWidget {
  const AfterGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final game = ref.watch(gameProvider);

      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
          child: Stack(alignment: Alignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const AppLogo(),
              Helpers.getVerticalSpacer(10),
              const Text("Le jeu est terminé",
                  style: TextStyle(fontSize: 25, color: textColor)),
              Helpers.getVerticalSpacer(2),
              Text("Votre score est : ${game.score}",
                  style: const TextStyle(
                      fontSize: 25,
                      color: textColor,
                      fontWeight: FontWeight.bold))
            ]),
            Positioned(
                bottom: 10,
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 20,
                    child: RoundedPurpleButton(
                        label: "Réessayer",
                        callback: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false))))
          ]));
    }));
  }
}
