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
          //hexa
          question: "Under the hill he holds high, how many souls gather for shelter?",
          answer: "14",
          encodedClue: "46 69 6e 64 20 74 68 65 20 63 6f 75 6e 74 20 6f 66 20 73 68 69 6e 69 6e 67 20 73 74 6f 6e 65 73 20 6f 6e 20 74 68 65 20 68 65 61 64 20 6f 66 20 74 68 65 20 62 6c 69 6e 64 20 6b 69 6e 67",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
        PuzzleQuestion(
          //base32
          question: "Draped in a color of dawn's glow, what hue adorns the hero’s lower garment?",
          answer: "Yellow",
          encodedClue: "46 69 6e 64 20 74 68 65 20 63 6f 75 6e 74 20 6f 66 20 73 68 69 6e 69 6e 67 20 73 74 6f 6e 65 73 20 6f 6e 20 74 68 65 20 68 65 61 64 20 6f 66 20 74 68 65 20 62 6c 69 6e 64 20 6b 69 6e 67",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
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
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
        PuzzleQuestion(
          question: "The one standing fearless on the chariot. Who is this warrior, revered by both friend and foe?",
          answer: "Bhishma",
          encodedClue: "KRUGK4TFMRZTELLCMFXGC3LFONZWK4Q=",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/draupadi_scene.jpg',
      name: 'Samudra Manthan',
      encodingType: EncodingType.base85,
      questions: [
        PuzzleQuestion(
          question: "In the court of kings, as dishonor loomed, a divine savior appeared to protect her. Who is this protector?",
          answer: "Krishna",
          encodedClue: "9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gpd7F!,L7@<6@)/0JDEF<G%<+EV:2F!O<DJ+*.@<*K0@<6L(",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
        PuzzleQuestion(
          question: "As the divine savior answered her call, an endless fabric of a single hue flowed to protect her honor. What is the color of this miraculous cloth?",
          answer: "White",
          encodedClue: "9jqo^BlbD-BleB1DJ+*+F(f,q/0JhKF<GL>Cj@.4Gpd7F!,L7@<6@)/0JDEF<G%<+EV:2F!O<DJ+*.@<*K0@<6L(",
          encodedCode: 'fhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhixueeeeeeeeeeeehfffffffffffffffffffffffffffffffffffffffffffffffffff',
        ),
      ],
    ),
    PuzzleImage(
      imagePath: 'assets/images/arjuna_aiming.png',
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

/*
base32:
A secret message wrapped in code,
With symbols in patterns to lighten the load.
Five bits at a time, I hide in plain sight,
Some digits removed to keep it just right.

A base uncommon, not too high nor low,
Find me if you can—what am I?

base85
I’m a packed mystery in letters and signs,
Stretching bytes farther, defying confines.
Less common, I dwell in places obscure,
Where four fits in five, compressed and secure.

What base do I call home?

url encoding:
I walk hidden paths where symbols aren’t free,
Marking detours with signs you can’t see.
In covert trails, I cloak what’s plain,
Following hex rules to mask the mundane.

What am I?

Hexadecimal
My symbols are few, yet stretch far and wide,
Where numbers and letters dare to collide.
In pairs I travel, orderly and clean,
Ancient yet common, with sixteen as my scene.

Who am I?
 */