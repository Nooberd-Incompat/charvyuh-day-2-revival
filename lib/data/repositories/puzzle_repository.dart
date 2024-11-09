import 'dart:math';

import '../../core/enums/encoding_type.dart';
import '../../core/models/puzzle_image.dart';
import '../../core/models/puzzle_question.dart';

class PuzzleRepository {
  static final List<PuzzleImage> puzzleImages = [
    PuzzleImage(
      imagePath: 'assets/images/arjuna.jpeg',
      name: 'Court Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          question: "How many jewels adorn the king's crown?",
          answer: "7",
          encodedClue: "46 69 6e 64 20 74 68 65 20 63 6f 75 6e 74 20 6f 66 20 73 68 69 6e 69 6e 67 20 73 74 6f 6e 65 73 20 6f 6e 20 74 68 65 20 68 65 61 64 20 6f 66 20 74 68 65 20 62 6c 69 6e 64 20 6b 69 6e 67",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/arjuna.jpeg',
      name: 'Arjuna\'s Aim',
      encodingType: EncodingType.base32,
      questions: [
        PuzzleQuestion(
          question: "What is the color of the feather on Arjuna's arrow?",
          answer: "White",
          encodedClue: "KRUGK4TFMRZTELLCMFXGC3LFONZWK4Q=",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/arjuna.jpeg',
      name: 'Samudra Manthan',
      encodingType: EncodingType.base85,
      questions: [
        PuzzleQuestion(
          question: "What creature holds the serpent's tail?",
          answer: "Eagle",
          encodedClue: "9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gpd7F!,L7@<6@)/0JDEF<G%<+EV:2F!O<DJ+*.@<*K0@<6L(",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/arjuna.jpeg',
      name: 'Bhima\'s Might',
      encodingType: EncodingType.urlEncoding,
      questions: [
        PuzzleQuestion(
          question: "How many rings are on Bhima's mace?",
          answer: "5",
          encodedClue: "How%20many%20circles%20of%20power%20does%20the%20mighty%20mace%20bear%3F",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
  ];

  PuzzleImage getRandomPuzzle() {
    return puzzleImages[Random().nextInt(puzzleImages.length)];
  }
}