import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_game/pages/after_game.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';
import 'package:gemini_game/widgets/response_reaction.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';
import 'package:gemini_game/widgets/rounded_transparent_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const ResponseReaction(
              isTrue: true,
              note: 96,
            ),
            Positioned(
                top: 40,
                left: 0,
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: blueTransparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Image 1/5",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Positioned(
                top: 40,
                right: 0,
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: blueTransparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "0/500",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Positioned(
                bottom: 10,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedTransparentButton(
                        label: "Passer",
                        callback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AfterGamePage()));
                        },
                      ),
                      Helpers.getHorizontalSpacer(3),
                      RoundedPurpleButton(
                        label: "Prendre une photo",
                        callback: () {},
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
