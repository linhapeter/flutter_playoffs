import 'package:flutter/material.dart';
import 'global_navigation_bar.dart';
import 'playoff_fab.dart';
import 'series_list.dart';
import 'app_bar.dart';
import 'api_service.dart';  // Import the ApiService


class PlayoffsScreen extends StatefulWidget {
  final int initialIndex;  // Added to accept the initial index

  PlayoffsScreen({this.initialIndex = 0});  // Default to 0 if not provided

  @override
  _PlayoffsScreenState createState() => _PlayoffsScreenState();
}

class _PlayoffsScreenState extends State<PlayoffsScreen> {
  late int _selectedIndex;
  List<Widget> _pages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;  // Use the initialIndex provided
    // Initially populate _pages with placeholders
    _pages = List.generate(4, (index) => Center(child: CircularProgressIndicator()));
    loadSeriesData();
  }

  void loadSeriesData() async {
    try {
      List<Map<String, dynamic>> seriesData = await ApiService().fetchSeries();
      // Filter the series data by series abbreviation
      List<Map<String, dynamic>> r1Series = seriesData.where((s) => s['seriesAbbrev'] == 'R1').toList();
      List<Map<String, dynamic>> r2Series = seriesData.where((s) => s['seriesAbbrev'] == 'R2').toList();
      List<Map<String, dynamic>> cfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'ECF' || s['seriesAbbrev'] == 'WCF').toList();
      List<Map<String, dynamic>> scfSeries = seriesData.where((s) => s['seriesAbbrev'] == 'SCF').toList();

      setState(() {
        _pages = [
          SeriesList(series: r1Series),
          SeriesList(series: r2Series),
          SeriesList(series: cfSeries),
          SeriesList(series: scfSeries),
        ];
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load data: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'PLAYOFFS'),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : _pages[_selectedIndex],
      bottomNavigationBar: GlobalNavigationBar(),
      floatingActionButton: const PlayoffFAB(),
    );
  }
}
