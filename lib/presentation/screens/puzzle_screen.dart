import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:chakra_level1/presentation/screens/success_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  late PuzzleImage _currentImage;
  late PuzzleQuestion _currentQuestion;
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectRandomPuzzle();
  }

  void _selectRandomPuzzle() {
    final random = Random();
    _currentImage = PuzzleRepository.puzzleImages[random.nextInt(PuzzleRepository.puzzleImages.length)];
    _currentQuestion = _currentImage.questions[random.nextInt(_currentImage.questions.length)];
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        // For Android 13 and above
        final status = await Permission.photos.request();
        return status.isGranted;
      } else {
        // For Android 12 and below
        final storage = await Permission.storage.request();
        return storage.isGranted;
      }
    }
    return true;
  }

  Future<void> _downloadTextFile() async {
    try {
      // Request appropriate storage permission first
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Storage permission is required to download files'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Get the downloads directory
      final directory = await _getDownloadPath();
      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      final fileName = _currentQuestion.codeFilePath.split('/').last;
      final filePath = '${directory.path}/$fileName';

      // Copy file from assets to downloads
      ByteData data = await rootBundle.load(_currentQuestion.codeFilePath);
      List<int> bytes = data.buffer.asUint8List();
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File downloaded successfully to ${directory.path}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<Directory?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        // Get the downloads directory on Android
        directory = Directory('/storage/emulated/0/Download');
        // Create the directory if it doesn't exist
        if (!await directory.exists()) {
          directory = await directory.create(recursive: true);
        }
      } else {
        // For iOS and other platforms, use the documents directory
        directory = await getApplicationDocumentsDirectory();
      }
    } catch (e) {
      print('Error getting download path: $e');
    }
    return directory;
  }


  Widget _buildEncodedSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return ElevatedButton.icon(
      onPressed: _downloadTextFile,
      icon: const Icon(Icons.download),
      label: const Text('Download Code File'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode the Mystery'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Quest:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentQuestion.question,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    _buildEncodedSection('Encoded Clue', _currentQuestion.encodedClue),
                    const SizedBox(height: 16),
                    _buildDownloadButton(),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        labelText: 'Your Answer',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.question_answer),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_answerController.text.trim().toLowerCase() ==
                              _currentQuestion.answer.toLowerCase()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(teamId: widget.teamId),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Incorrect answer. Try again!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Text(
                            'Submit Answer',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
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