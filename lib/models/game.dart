class Game {
  final int index;
  final int score;
  final bool isLoading;
  final int noteToAdd;
  final bool isCorrect;
  final bool showAnswer;

  Game(
      {required this.index,
      required this.score,
      required this.isLoading,
      required this.noteToAdd,
      required this.isCorrect,
      required this.showAnswer});

  Game copyWith(
      {int? index,
      int? score,
      String? itemToFind,
      bool? isLoading,
      int? noteToAdd,
      bool? isCorrect,
      bool? showAnswer}) {
    return Game(
        index: index ?? this.index,
        score: score ?? this.score,
        isLoading: isLoading ?? this.isLoading,
        noteToAdd: noteToAdd ?? this.noteToAdd,
        isCorrect: isCorrect ?? this.isCorrect,
        showAnswer: showAnswer ?? this.showAnswer);
  }
}
