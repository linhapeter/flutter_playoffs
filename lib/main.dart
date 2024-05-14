import 'package:flutter/material.dart';
import 'home_screen.dart';


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
     home: HomeScreen(),
    );
  }
}
