import 'package:flutter/material.dart';
import 'series_screen.dart';  // First screen for each tab

class NavigatorWidget extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> seriesData;


  NavigatorWidget({required this.index, required this.seriesData});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return SeriesScreen(index: index, seriesData: seriesData);
          },
        );
      },
    );
  }
}
