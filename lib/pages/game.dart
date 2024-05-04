import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_game/providers/game.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gemini_game/api/gemini_api.dart';
import 'package:gemini_game/pages/after_game.dart';
import 'package:gemini_game/pages/loading.dart';
import 'package:gemini_game/repositories/gemini_repository.dart';
import 'package:gemini_game/themes/colors.dart';
import 'package:gemini_game/utils/photo_picker.dart';
import 'package:gemini_game/widgets/response_reaction.dart';
import 'package:gemini_game/widgets/rounded_purple_button.dart';
import 'package:gemini_game/widgets/rounded_transparent_button.dart';

class GamePage extends StatelessWidget {
  final List<String> items;

  const GamePage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final game = ref.watch(gameProvider);

          void onPhotoTaken(image) async {
            if (image == null) return;

            ref.read(gameProvider.notifier).startLoading();

            GeminiRepository geminiRepository =
                GeminiRepository(client: GeminiApi(type: "gemini-pro-vision"));
            geminiRepository
                .validateImage(items[game.index - 1], image)
                .then((value) {
              ref.read(gameProvider.notifier).stopLoading();
              ref.read(gameProvider.notifier).setShowAnswer(true);
              ref.read(gameProvider.notifier).setCorrect(value.$1);
              ref.read(gameProvider.notifier).setNoteToAdd(value.$2);
              ref.read(gameProvider.notifier).updateScore();
            });
          }

          return game.isLoading
              ? const LoadingPage(text: "Validation de l'image")
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Stack(alignment: Alignment.center, children: [
                    !game.showAnswer
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Élément à trouver:",
                                  style: TextStyle(
                                      fontSize: 25, color: textColor)),
                              const SizedBox(height: 8),
                              Text(items[game.index - 1],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: textColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        : const ResponseReaction(),
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
                            child: Text("Image ${game.index}/5",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)))),
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
                            child: Text("${game.score}/500",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)))),
                    Positioned(
                      bottom: 10,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          child: game.showAnswer
                              ? RoundedPurpleButton(
                                  label: "Suivant",
                                  callback: () {
                                    if (game.index == 5) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AfterGamePage()));
                                    } else {
                                      ref
                                          .read(gameProvider.notifier)
                                          .incrementIndex();
                                    }
                                  })
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      RoundedTransparentButton(
                                          label: "Passer",
                                          callback: () {
                                            if (game.index == 5) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AfterGamePage()));
                                            } else {
                                              ref
                                                  .read(gameProvider.notifier)
                                                  .incrementIndex();
                                            }
                                          }),
                                      const SizedBox(width: 8),
                                      RoundedPurpleButton(
                                          label: "Prendre une photo",
                                          callback: () async {
                                            var image = await PhotoPicker(
                                                    imagePicker: ImagePicker())
                                                .takePhoto();
                                            onPhotoTaken(image);
                                          })
                                    ])),
                    )
                  ]));
        },
      ),
    );
  }
}
