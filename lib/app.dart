import 'package:flutter/material.dart';
import 'presentation/screens/team_id_screen.dart';
import 'core/constants/theme_constants.dart';

class ChakravyuhApp extends StatelessWidget {
  const ChakravyuhApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chakravyuh',
      theme: appTheme,
      home: TeamIdScreen(),
    );
  }
}