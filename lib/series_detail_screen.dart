import 'package:flutter/material.dart';
import 'games_list.dart';
import 'api_service.dart';

class SeriesDetailScreen extends StatefulWidget {
  final String seriesLetter;
  final String topLogo;
  final String bottomLogo;
  final int topId;
  final int bottomId;

  SeriesDetailScreen({
    required this.seriesLetter,
    required this.topLogo,
    required this.bottomLogo,
    required this.topId,
    required this.bottomId,
  });

  @override
  _SeriesDetailScreenState createState() => _SeriesDetailScreenState();
}

class _SeriesDetailScreenState extends State<SeriesDetailScreen> {
  late List<Map<String, dynamic>> _gamesData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGamesData();
  }

  void _printGamesData(List<Map<String, dynamic>> gamesData) {
    for (var game in gamesData) {
      print('Game ID: ${game['gameId']}');
      if (game.containsKey('details')) {
        print('Details for Game ${game['gameId']}: ${game['details']}');
      } else {
        print('No details found for Game ${game['gameId']}');
      }
    }
  }

  void _loadGamesData() async {
    try {
      List<Map<String, dynamic>> gamesData = await ApiService().fetchGamesAndDetails(widget.seriesLetter);
      setState(() {
        _gamesData = gamesData;
        _printGamesData(gamesData); // More detailed data printing
        print(gamesData);
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GamesList(games: _gamesData, serieData: {
              'seriesLetter': widget.seriesLetter,
              'topLogo': widget.topLogo,
              'bottomLogo': widget.bottomLogo,
              'topId': widget.topId,
              'bottomId': widget.bottomId,
            }),
    );
  }
}
