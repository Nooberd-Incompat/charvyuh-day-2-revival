import 'dart:math';

import '../../core/enums/encoding_type.dart';
import '../../core/models/puzzle_image.dart';
import '../../core/models/puzzle_question.dart';


/*
keep_guessing -> arjun
guess->bhishma
honor->draupadi
revelations->eklavya
purgatory->gandhari
past_comes_back->kamsa
vigliant->krishna
rex_caecus->dhritrahstra
codefile->chariot scene
massacre ->mahabharat


 */
class PuzzleRepository {
  static final List<PuzzleImage> puzzleImages = [
    PuzzleImage(
      //ARJUN
      //base64
      id: "arjuna_1", // Added ID for the image
      imagePath: 'assets/images/arjuna_aiming.png',
      name: 'Arjuna\'s Aim',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "arjuna_q1", // Added ID for the question
          question: "Who is holding the weapon?",
          answer: "Arjun",
          encodedClue:  """
        I turn plain text to a cryptic stream,
With letters, digits, and symbols, it seems.
No cloak of disguise, but compact in form,
Reducing the size is my typical norm.
I pad with equals, round off my ends,
In groups of three, my work depends.
What am I?
    """,
          codeFilePath: 'assets/codes/keep_guessing.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base32
      id: "bhishma_1",
      imagePath: 'assets/images/bhishma_scene.jpg',
      name: 'Bhishma Scene',
      encodingType: EncodingType.base32,
      questions: [
        PuzzleQuestion(
          id: "bhishma_q1",
          question: "How many horses are there and what is the colour of the mighty hero's dhoti. Format of the answer: 14 Black",
          answer: "3 Yellow",
          encodedClue: """I take your data and break it apart,
                          Into 32 symbols, to play my part.
                          It’s still there, but hard to find,
                          A simple encoding for peace of mind.
                          What am I?""",
          codeFilePath: 'assets/codes/guess.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base45
      id: "draupadi_1",
      imagePath: 'assets/images/draupadi_scene.jpg',
      name: 'Draupadi Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "draupadi_q1",
          question: "What is the colour of her cloth and who is on top right corner. Format of the answer: Colour Naruto",
          answer: "White Krishna",
          encodedClue: """I’m compact and clever, not often in sight,
In the world of QR, I make data light.
A mix of letters and numbers I hold,
Shrinking bytes down, precise and controlled.

Not hex, nor sixty-four, but tailored to fit,
In a specialized role, I quietly sit.
What am I?""",
          codeFilePath: 'assets/codes/honor.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base85
      id: "ekalavya_1",
      imagePath: 'assets/images/ekalavya_scene.jpg',
      name: 'Ekalavya Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "ekalavya_q1",
          question: "What is the student holding in his hand, which hand is it and how many people are there in image. Format of Ans: Iphone Which_Hand 400",
          answer: "Knife 3",
          encodedClue: """I take your text and stretch it wide,
                          With 85 symbols, nothing to hide.
It’s compact, it’s dense, it’s hard to decode,
But useful when you need a lighter load.
What am I?""",
          codeFilePath: 'assets/codes/revelations.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base32
      id: "gandhari_1",
      imagePath: 'assets/images/gandhari_scene.jpg',
      name: 'Gandhari Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "gandhari_q1",
          question: "How many human legs are visible and what is the colour of the saree. Format of Ans: 79 Black",
          answer: "5 Yellow",
          encodedClue: """I take your data and break it apart,
Into 32 symbols, to play my part.
It’s still there, but hard to find,
A simple encoding for peace of mind.
What am I?""",
          codeFilePath: 'assets/codes/purrgatory.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base64
      id: "kamsa_1",
      imagePath: 'assets/images/kamsa_scene.jpg',
      name: 'Kamsa Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "kamsa_q1",
          question: "What are the objects fallen on the ground. Format of Ans: Pen Pencil KanyeWest",
          answer: "Crown Sword Shield",
          encodedClue: """I turn your text into a form obscure,
With letters and digits, I’m easy to endure.
I scramble things, but not for disguise,
Just to make them fit in a smaller size.
What am I?""",
          codeFilePath: 'assets/codes/past_comes_back.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base45
      id: "krishna_mountain_1",
      imagePath: 'assets/images/krishna_mountain.jpg',
      name: 'Krishna Mountain Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "krishna_mountain_q1",
          question: "Under the hill he holds high, how many humans gather for shelter?",
          answer: "16",
          encodedClue: """I’m compact and clever, not often in sight,
In the world of QR, I make data light.
A mix of letters and numbers I hold,
Shrinking bytes down, precise and controlled.

Not hex, nor sixty-four, but tailored to fit,
In a specialized role, I quietly sit.
What am I?""",
          codeFilePath: 'assets/codes/vigilant.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base85
      id: "dhritarashtra_1",
      imagePath: 'assets/images/dhritarashtra_scene.jpg',
      name: 'Dhritarashtra Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          //base85
          id: "dhritarashtra_q1",
          question: "What is the colour of the messenger , the king and the cushions he is sitting on. Format of Ans: Pink Red Blue",
          answer: "14",
          encodedClue: """I take your text and stretch it wide,
With 85 symbols, nothing to hide.
It’s compact, it’s dense, it’s hard to decode,
But useful when you need a lighter load.
What am I?""",
          codeFilePath: 'assets/codes/rex_caecus.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base92
      id: "mahabharat_1",
      imagePath: 'assets/images/mahabharat.jpg',
      name: 'Krishna Advice Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "mahabharat_q1",
          question: "What divine weapon is being discussed and to whom? Format: Sudarshan Arjuna",
          answer: "14",
          encodedClue: """Some clue about base92 encoding""",
          codeFilePath: 'assets/codes/massacre.txt',
        ),
      ],
    ),
    PuzzleImage(
      //base92
      id: "chariot_1",
      imagePath: 'assets/images/krishna_advice.jpg',
      name: 'Krishna Advice Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "chariot_q1",
          question: "What divine weapon is being discussed and to whom? Format: Sudarshan Arjuna",
          answer: "14",
          encodedClue: """Some clue about base92 encoding""",
          codeFilePath: 'assets/codes/codefile.txt',
        ),
      ],
    ),

  ];

  // Modified to return both image and question for better control
  static PuzzleQuestion getRandomQuestion() {
    final random = Random();
    final randomImage = puzzleImages[random.nextInt(puzzleImages.length)];
    return randomImage.questions[random.nextInt(randomImage.questions.length)];
  }

  // Get a specific question by ID
  static PuzzleQuestion? getQuestionById(String id) {
    for (var image in puzzleImages) {
      for (var question in image.questions) {
        if (question.id == id) {
          return question;
        }
      }
    }
    return null;
  }

  // Get total number of questions available
  static int get totalQuestions {
    return puzzleImages.fold(0, (sum, image) => sum + image.questions.length);
  }
}


/*
base64
I turn your text into a form obscure,
With letters and digits, I’m easy to endure.
I scramble things, but not for disguise,
Just to make them fit in a smaller size.
What am I?

//new one
I turn plain text to a cryptic stream,
With letters, digits, and symbols, it seems.
No cloak of disguise, but compact in form,
Reducing the size is my typical norm.
I pad with equals, round off my ends,
In groups of three, my work depends.
What am I?


base32
I take your data and break it apart,
Into 32 symbols, to play my part.
It’s still there, but hard to find,
A simple encoding for peace of mind.
What am I?

base45
I’m compact and clever, not often in sight,
In the world of QR, I make data light.
A mix of letters and numbers I hold,
Shrinking bytes down, precise and controlled.

Not hex, nor sixty-four, but tailored to fit,
In a specialized role, I quietly sit.
What am I?



base85
I take your text and stretch it wide,
With 85 symbols, nothing to hide.
It’s compact, it’s dense, it’s hard to decode,
But useful when you need a lighter load.
What am I?

base92
I stretch beyond the common scale,
Not limited by sixty-four or fifty-eight,
A curious set where symbols trail,
Packed tightly, no room for fate.
With ninety-three in hand,
I drop one, and then I stand.
What am I?
*/
