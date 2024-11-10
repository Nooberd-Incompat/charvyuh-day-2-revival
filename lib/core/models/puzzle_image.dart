import '../enums/encoding_type.dart';
import 'puzzle_question.dart';

class PuzzleImage {
  final String id;
  final String imagePath;
  final String name;
  final EncodingType encodingType;
  final List<PuzzleQuestion> questions;

  PuzzleImage({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.encodingType,
    required this.questions,
  });
}