import 'package:flutter/material.dart';

import 'series_list.dart'; // Second screen to navigate to

class SeriesScreen extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> seriesData;

  SeriesScreen({required this.index, required this.seriesData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SeriesList(series: seriesData),
    ),
    );
  }
}
