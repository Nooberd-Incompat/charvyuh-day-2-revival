import 'dart:math';

import '../../core/enums/encoding_type.dart';
import '../../core/models/puzzle_image.dart';
import '../../core/models/puzzle_question.dart';

class PuzzleRepository {
  static final List<PuzzleImage> puzzleImages = [
    PuzzleImage(
      imagePath: 'assets/images/krishna_mountain.jpg',
      name: 'Court Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          question: "Under the hill he holds high, how many souls gather for shelter?",
          answer: "14",
          encodedClue: "46 69 6e 64 20 74 68 65 20 63 6f 75 6e 74 20 6f 66 20 73 68 69 6e 69 6e 67 20 73 74 6f 6e 65 73 20 6f 6e 20 74 68 65 20 68 65 61 64 20 6f 66 20 74 68 65 20 62 6c 69 6e 64 20 6b 69 6e 67",
          codeFilePath: 'assets/codes/draupadi.txt',
        ),
        PuzzleQuestion(
          question: "Draped in a color of dawn's glow, what hue adorns the hero's lower garment?",
          answer: "Yellow",
          encodedClue: "46 69 6e 64 20 74 68 65 20 63 6f 75 6e 74 20 6f 66 20 73 68 69 6e 69 6e 67 20 73 74 6f 6e 65 73 20 6f 6e 20 74 68 65 20 68 65 61 64 20 6f 66 20 74 68 65 20 62 6c 69 6e 64 20 6b 69 6e 67",
          codeFilePath: 'assets/codes/draupadi.txt',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/bhishma_scene.jpg',
      name: 'Arjuna\'s Aim',
      encodingType: EncodingType.base32,
      questions: [
        PuzzleQuestion(
          question: "In a fierce moment, the charioteer abandons his vow, wielding a mighty wheel against the grandsire. What weapon does he hold high in his hand?",
          answer: "Chariot Wheel",
          encodedClue: "KRUGK4TFMRZTELLCMFXGC3LFONZWK4Q=",
          codeFilePath: 'assets/codes/draupadi.txt',
        ),
        PuzzleQuestion(
          question: "The one standing fearless on the chariot. Who is this warrior, revered by both friend and foe?",
          answer: "Bhishma",
          encodedClue: "KRUGK4TFMRZTELLCMFXGC3LFONZWK4Q=",
          codeFilePath: 'assets/codes/draupadi.txt',
        ),
      ],
    ),
    // ... rest of the images with similar modifications
  ];

  PuzzleImage getRandomPuzzle() {
    return puzzleImages[Random().nextInt(puzzleImages.length)];
  }
}