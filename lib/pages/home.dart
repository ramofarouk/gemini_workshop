import 'package:flutter/material.dart';
import 'package:gemini_game/api/gemini_api.dart';
import 'package:gemini_game/models/environment.dart';
import 'package:gemini_game/pages/game.dart';

import 'package:gemini_game/pages/loading.dart';
import 'package:gemini_game/repositories/gemini_repository.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';
import 'package:gemini_game/widgets/logo.dart';
import 'package:gemini_game/widgets/place_card.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int type = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const LoadingPage(text: "Préparation de la partie")
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const AppLogo(),
                      Helpers.getVerticalSpacer(4),
                      const Text(
                        "Choisir votre environnement",
                        style: TextStyle(fontSize: 20, color: textColor),
                      ),
                      Helpers.getVerticalSpacer(6),
                      Row(
                        children: [
                          PlaceCard(
                            label: "Maison",
                            image: "assets/house.png",
                            callback: () {
                              setState(() {
                                type = 1;
                              });
                            },
                            isChoose: type == 1,
                          ),
                          Helpers.getHorizontalSpacer(2),
                          PlaceCard(
                              label: "Travail",
                              image: "assets/work.png",
                              callback: () {
                                setState(() {
                                  type = 2;
                                });
                              },
                              isChoose: type == 2)
                        ],
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 20,
                          child: RoundedPurpleButton(
                              label: "Commencer le jeu",
                              radius: 10,
                              callback: () {
                                if (type == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Veuillez choisir votre environnement")));
                                } else {
                                  getData();
                                }
                              })))
                ],
              ),
            ),
    );
  }

  void getData() {
    setState(() {
      isLoading = true;
    });

    GeminiRepository geminiRepository =
        GeminiRepository(client: GeminiApi(type: "gemini-pro"));
    geminiRepository
        .loadObjects(GameEnvironment.values.elementAt(type - 1))
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GamePage(items: value)),
            (route) => false));
  }
}
