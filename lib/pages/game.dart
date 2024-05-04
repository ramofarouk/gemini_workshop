import 'package:flutter/material.dart';
import 'package:gemini_game/api/gemini_api.dart';
import 'package:gemini_game/pages/after_game.dart';
import 'package:gemini_game/pages/loading.dart';
import 'package:gemini_game/repositories/gemini_repository.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/helpers.dart';
import 'package:gemini_game/utils/photo_picker.dart';
import 'package:gemini_game/widgets/response_reaction.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';
import 'package:gemini_game/widgets/rounded_transparent_button.dart';
import 'package:image_picker/image_picker.dart';

class GamePage extends StatefulWidget {
  final List<String> items;
  const GamePage({super.key, required this.items});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int index = 1;
  bool isLoading = false;
  int score = 0;
  bool isCorrect = false;
  int noteToAdd = 0;
  bool isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const LoadingPage(text: "Validation de l'image")
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  isSubmitted
                      ? ResponseReaction(isTrue: isCorrect, note: noteToAdd)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Élement à trouver",
                              style: TextStyle(fontSize: 25, color: textColor),
                            ),
                            Text(widget.items[index - 1],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: textColor))
                          ],
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
                        child: Text(
                          "Image $index/5",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                        child: Text(
                          "$score/500",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  Positioned(
                      bottom: 10,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 20,
                        child: isSubmitted
                            ? RoundedPurpleButton(
                                label: "Suivant",
                                callback: () {
                                  if (index < 5) {
                                    setState(() {
                                      isSubmitted = false;
                                      index++;
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AfterGamePage(
                                                  score: score,
                                                )));
                                  }
                                },
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedTransparentButton(
                                    label: "Passer",
                                    callback: () {
                                      if (index < 5) {
                                        setState(() {
                                          index++;
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AfterGamePage(
                                                      score: score,
                                                    )));
                                      }
                                    },
                                  ),
                                  Helpers.getHorizontalSpacer(3),
                                  RoundedPurpleButton(
                                    label: "Prendre une photo",
                                    callback: () {
                                      checkImage();
                                    },
                                  )
                                ],
                              ),
                      ))
                ],
              ),
            ),
    );
  }

  checkImage() async {
    var image = await PhotoPicker(imagePicker: ImagePicker()).takePhoto();
    setState(() {
      isLoading = true;
    });
    GeminiRepository geminiRepository =
        GeminiRepository(client: GeminiApi(type: "gemini-pro-vision"));
    geminiRepository
        .validateImage(widget.items[index - 1], image)
        .then((value) => analyzeData(value));
  }

  analyzeData(value) {
    setState(() {
      isCorrect = value.$1;
      noteToAdd = value.$2;
      isLoading = false;
      isSubmitted = true;
      isCorrect ? score += noteToAdd : score;
    });
  }
}
