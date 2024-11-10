import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:chakra_level1/presentation/screens/success_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import '../../core/models/puzzle_image.dart';
import '../../core/models/puzzle_question.dart';
import '../../data/repositories/puzzle_repository.dart';

class PuzzleScreen extends StatefulWidget {
  final String teamId;

  PuzzleScreen({required this.teamId});

  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late List<PuzzleImage> _availableQuestions;
  late PuzzleImage _currentImage;
  late PuzzleQuestion _currentQuestion;
  final _answerController = TextEditingController();
  int _solvedCount = 0;
  Set<String> _solvedQuestions = {}; // Using Set for more efficient lookups

  @override
  void initState() {
    super.initState();
    _checkInitialPermissions();
    _initializeQuestions();
  }

  void _initializeQuestions() {
    _availableQuestions = List.from(PuzzleRepository.puzzleImages);
    _selectRandomPuzzle();
  }

  // Method to check initial permissions
  Future<void> _checkInitialPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        await Permission.photos.request();
        await Permission.videos.request();
      } else {
        await Permission.storage.request();
      }
    }
  }

  // Method to request the necessary permissions
  Future<Map<Permission, PermissionStatus>> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = {};

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        statuses = await [Permission.photos, Permission.videos].request();
      } else {
        statuses = await [Permission.storage].request();
      }
    } else if (Platform.isIOS) {
      statuses = await [Permission.photos].request();
    }

    return statuses;
  }

  // Handle permission request and show dialog if denied
  Future<bool> _handlePermissionRequest() async {
    final statuses = await _requestPermissions();

    final denied = statuses.values
        .any((status) => status.isDenied || status.isPermanentlyDenied);
    if (denied) {
      if (mounted) {
        _showPermissionDeniedDialog();
      }
      return false;
    }

    return true;
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'This feature requires storage permission to download files. '
              'Please grant the permission in your device settings to continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  // Copy asset file to local directory
  Future<String> _copyAssetToLocalDirectory(String assetPath) async {
    final fileName = assetPath.split('/').last;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';

    try {
      final byteData = await rootBundle.load(assetPath);
      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return filePath;
    } catch (e) {
      print("Error copying asset to local directory: $e");
      return '';
    }
  }

  void _selectRandomPuzzle() {
    if (_availableQuestions.isEmpty) {
      _initializeQuestions();
    }

    final random = Random();

    // Create a list of all available questions that haven't been solved
    List<(PuzzleImage, PuzzleQuestion)> availablePairs = [];

    for (var image in _availableQuestions) {
      for (var question in image.questions) {
        // Using question and answer combination as a unique identifier
        String questionKey = '${question.question}_${question.answer}';
        if (!_solvedQuestions.contains(questionKey)) {
          availablePairs.add((image, question));
        }
      }
    }

    if (availablePairs.isEmpty) {
      // If all questions are solved, reset the list
      _solvedQuestions.clear();
      _initializeQuestions();
      return;
    }

    // Select a random question from available pairs
    final randomPair = availablePairs[random.nextInt(availablePairs.length)];
    _currentImage = randomPair.$1;
    _currentQuestion = randomPair.$2;
    _answerController.clear();
  }

  void _handleNextQuestion() {
    setState(() {
      _selectRandomPuzzle();
    });
  }

  void _handleCorrectAnswer() {
    setState(() {
      _solvedCount++;
      // Store question+answer combination instead of ID
      _solvedQuestions
          .add('${_currentQuestion.question}_${_currentQuestion.answer}');

      if (_solvedCount >= 5) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SuccessScreen(teamId: widget.teamId)),
        );
      } else {
        _selectRandomPuzzle();
      }
    });
  }

  // Copy to clipboard functionality
  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Download the text file
  Future<void> _downloadTextFile() async {
    final hasPermission = await _handlePermissionRequest();
    if (!hasPermission) {
      return;
    }

    try {
      final directory = await _getDownloadPath();
      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      if (mounted) {
        _showDownloadProgress();
      }

      final filePath =
          await _copyAssetToLocalDirectory(_currentQuestion.codeFilePath);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File downloaded successfully to $filePath'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'VIEW',
              onPressed: () {
                OpenFile.open(filePath);
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Show download progress dialog
  void _showDownloadProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Downloading file...'),
            ],
          ),
        );
      },
    );
  }

  // Get the download path
  Future<Directory?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await directory.create(recursive: true);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
    } catch (e) {
      print('Error getting download path: $e');
    }
    return directory;
  }

  // Build encoded clue section
  Widget _buildEncodedSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.copy, size: 20),
              onPressed: () => _copyToClipboard(content, title),
              tooltip: 'Copy to clipboard',
            ),
          ],
        ),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: SelectableText(
              content,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  // Build download button
  Widget _buildDownloadButton() {
    return ElevatedButton.icon(
      onPressed: _downloadTextFile,
      icon: const Icon(Icons.download),
      label: const Text('Download Code File'),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode the Mystery'),
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Questions Solved: $_solvedCount/5',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Quest:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _currentQuestion.question,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 24),
                    _buildEncodedSection(
                        'Encoded Clue', _currentQuestion.encodedClue),
                    const SizedBox(height: 20),
                    _buildDownloadButton(),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: 'Your Answer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.question_answer),
                        fillColor: Colors.grey.shade50,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_answerController.text.trim() ==
                                _currentQuestion.answer.trim()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Correct answer! Moving to next question.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _handleCorrectAnswer();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Incorrect answer. Try again!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Submit Answer'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: _handleNextQuestion,
                          icon: const Icon(Icons.skip_next),
                          label: const Text('Next Question'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
