import 'package:flutter/material.dart';
import 'games_list.dart';
import 'app_bar.dart';
import 'global_navigation_bar.dart';
import 'api_service.dart';
import 'playoff_fab.dart';  // Import the ApiService

class SerieDetail extends StatefulWidget {
  // Remove the constructor that takes seriesLetter directly
  SerieDetail({Key? key}) : super(key: key);

  @override
  _SerieDetailState createState() => _SerieDetailState();
}

class _SerieDetailState extends State<SerieDetail> {
  late String _passedSeriesLetter;
  late Map<String, dynamic> _serieData;
  List<Widget> _pages = [];
  bool _isLoading = true;  // To handle loading state

  @override
  void initState() {
    super.initState();
    // Initially populate _pages with placeholders
    _pages = List.generate(4, (index) => Center(child: CircularProgressIndicator()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract seriesLetter from route arguments safely after the widget build is complete
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    _passedSeriesLetter = args['seriesLetter'] ?? 'default';
    _serieData = args;
    loadGamesData();
  }

  void printGamesData(List<Map<String, dynamic>> gamesData) {
  for (var game in gamesData) {
    print('Game ID: ${game['gameId']}');
    if (game.containsKey('details')) {
      print('Details for Game ${game['gameId']}: ${game['details']}');
    } else {
      print('No details found for Game ${game['gameId']}');
    }
  }
}


 void loadGamesData() async {
  try {
    List<Map<String, dynamic>> gamesData = await ApiService().fetchGamesAndDetails(_passedSeriesLetter);
    setState(() {
      _pages = [GamesList(games: gamesData, serieData: _serieData)];
      printGamesData(gamesData); // More detailed data printing
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
      appBar: CustomAppBar(title: 'PLAYOFFS'),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : _pages[0],
      bottomNavigationBar: GlobalNavigationBar(),
      floatingActionButton: const PlayoffFAB(),
    );
  }
}
