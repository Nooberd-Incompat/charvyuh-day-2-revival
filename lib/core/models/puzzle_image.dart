import '../enums/encoding_type.dart';
import 'puzzle_question.dart';

class PuzzleImage {
  final String imagePath;
  final String name;
  final List<PuzzleQuestion> questions;
  final EncodingType encodingType;
  String? encodedData;

  PuzzleImage({
    required this.imagePath,
    required this.name,
    required this.questions,
    required this.encodingType,
  });
}