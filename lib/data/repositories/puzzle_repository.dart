import 'dart:math';

import '../../core/enums/encoding_type.dart';
import '../../core/models/puzzle_image.dart';
import '../../core/models/puzzle_question.dart';

class PuzzleRepository {
  static final List<PuzzleImage> puzzleImages = [
    PuzzleImage(
      id: "arjuna_1", // Added ID for the image
      imagePath: 'assets/images/arjuna_aiming.png',
      name: 'Arjuna\'s Aim',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "arjuna_q1", // Added ID for the question
          question: "Who is holding the weapon?",
          answer: "Arjun",
          encodedClue: "Some clue about base64 encoding",
          codeFilePath: 'assets/codes/keep_guessing.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "bhishma_1",
      imagePath: 'assets/images/bhishma_scene.jpg',
      name: 'Bhishma Scene',
      encodingType: EncodingType.base32,
      questions: [
        PuzzleQuestion(
          id: "bhishma_q1",
          question: "How many horses are there and what is the colour of the mighty hero's dhoti. Format of the answer: 14 Black",
          answer: "3 Yellow",
          encodedClue: "Some clue about base32 encoding",
          codeFilePath: 'assets/codes/guess.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "draupadi_1",
      imagePath: 'assets/images/draupadi_scene.jpg',
      name: 'Draupadi Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "draupadi_q1",
          question: "some question ... ",
          answer: "14",
          encodedClue: "Some clue about base58 encoding",
          codeFilePath: 'assets/codes/honor.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "ekalavya_1",
      imagePath: 'assets/images/ekalavya_scene.jpg',
      name: 'Ekalavya Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "ekalavya_q1",
          question: "What is the student holding in his hand, which hand is it and how many people are there in image. Format of Ans: Iphone Which_Hand 400",
          answer: "14",
          encodedClue: "Some clue about base85 encoding",
          codeFilePath: 'assets/codes/revelations.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "gandhari_1",
      imagePath: 'assets/images/gandhari_scene.jpg',
      name: 'Gandhari Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "gandhari_q1",
          question: "How many human legs are visible and what is the colour of the saree. Format of Ans: 79 Black",
          answer: "14",
          encodedClue: "Some clue about base32 encoding",
          codeFilePath: 'assets/codes/purrgatory.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "kamsa_1",
      imagePath: 'assets/images/kamsa_scene.jpg',
      name: 'Kamsa Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "kamsa_q1",
          question: "What are the objects fallen on the ground. Format of Ans: Pen Pencil KanyeWest",
          answer: "14",
          encodedClue: "Some clue about base64 encoding",
          codeFilePath: 'assets/codes/purrgatory.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "krishna_mountain_1",
      imagePath: 'assets/images/krishna_mountain.jpg',
      name: 'Krishna Mountain Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "krishna_mountain_q1",
          question: "Under the hill he holds high, how many souls gather for shelter?",
          answer: "14",
          encodedClue: "Some clue about base58 encoding",
          codeFilePath: 'assets/codes/purrgatory.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "dhritarashtra_1",
      imagePath: 'assets/images/dhritarashtra_scene.jpg',
      name: 'Dhritarashtra Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "dhritarashtra_q1",
          question: "What is unique about the king's appearance and what object is he holding? Format: Blindfolded Staff",
          answer: "14",
          encodedClue: "Some clue about base85 encoding",
          codeFilePath: 'assets/codes/purrgatory.txt',
        ),
      ],
    ),
    PuzzleImage(
      id: "krishna_advice_1",
      imagePath: 'assets/images/krishna_advice.jpg',
      name: 'Krishna Advice Scene',
      encodingType: EncodingType.hexadecimal,
      questions: [
        PuzzleQuestion(
          id: "krishna_advice_q1",
          question: "What divine weapon is being discussed and to whom? Format: Sudarshan Arjuna",
          answer: "14",
          encodedClue: "Some clue about base58 encoding",
          codeFilePath: 'assets/codes/purrgatory.txt',
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