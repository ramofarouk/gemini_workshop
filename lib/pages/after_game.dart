import 'package:flutter/material.dart';
import 'package:gemini_game/pages/home.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';
import 'package:gemini_game/widgets/logo.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';

class AfterGamePage extends StatefulWidget {
  final int score;
  const AfterGamePage({super.key, required this.score});

  @override
  State<AfterGamePage> createState() => _AfterGamePageState();
}

class _AfterGamePageState extends State<AfterGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppLogo(),
                Helpers.getVerticalSpacer(10),
                const Text(
                  "Le jeu est terminé",
                  style: TextStyle(fontSize: 25, color: textColor),
                ),
                Helpers.getVerticalSpacer(2),
                Text(
                  "Votre score est : ${widget.score}",
                  style: const TextStyle(
                      fontSize: 25,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Positioned(
                bottom: 10,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 20,
                  child: RoundedPurpleButton(
                    label: "Réessayer",
                    callback: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
