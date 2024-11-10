class PuzzleQuestion {
  final String id; // Add this field
  final String question;
  final String encodedClue;
  final String answer;
  final String codeFilePath;

  PuzzleQuestion({
    required this.id,
    required this.question,
    required this.encodedClue,
    required this.answer,
    required this.codeFilePath,
  });
}