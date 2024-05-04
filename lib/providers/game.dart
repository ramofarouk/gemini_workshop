import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_game/models/game.dart';

final gameProvider = StateNotifierProvider<GameNotifier, Game>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<Game> {
  GameNotifier()
      : super(Game(
          index: 1,
          score: 0,
          isLoading: false,
          noteToAdd: 0,
          isCorrect: false,
          showAnswer: false,
        ));

  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  void stopLoading() {
    state = state.copyWith(isLoading: false);
  }

  void setShowAnswer(bool value) {
    state = state.copyWith(showAnswer: value);
  }

  void setCorrect(bool value) {
    state = state.copyWith(isCorrect: value);
  }

  void setNoteToAdd(int value) {
    state = state.copyWith(noteToAdd: value);
  }

  void incrementIndex() {
    state = state.copyWith(
      index: state.index + 1,
      showAnswer: false,
      noteToAdd: 0,
    );
  }

  void updateScore() {
    state = state.copyWith(score: state.score + state.noteToAdd);
  }
}
