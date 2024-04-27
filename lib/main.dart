import 'package:flutter/material.dart';
import 'playoffs_screen.dart';
import 'serie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NHL Playoffs',
      theme: ThemeData.dark().copyWith(
        // Use copyWith to override specific properties on ThemeData.dark()
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.white,  // Set your desired color for progress indicators
        ),
      ),
      home: PlayoffsScreen(),
      routes: {
        '/playoffs/R1': (context) => PlayoffsScreen(initialIndex: 0),
        '/playoffs/R2': (context) => PlayoffsScreen(initialIndex: 1),
        '/playoffs/CF': (context) => PlayoffsScreen(initialIndex: 2),
        '/playoffs/SCF': (context) => PlayoffsScreen(initialIndex: 3),
        '/serieDetail': (context) => SerieDetail(),
      },
    );
  }
}
