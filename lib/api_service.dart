import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api-web.nhle.com/v1/playoff-bracket/2024";
  static const String seriesDetailUrl = "https://api-web.nhle.com/v1/schedule/playoff-series/20232024";
  static const String gameDetailUrl = "https://api-web.nhle.com/v1/gamecenter";
  Future<List<Map<String, dynamic>>> fetchSeries() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Map<String, dynamic>> series = (data['series'] as List).map((s) {
        return {
          'top': s['topSeedTeam']?['abbrev'] ?? '???', 
          'bottom': s['bottomSeedTeam']?['abbrev'] ?? '???',
          'topId': s['topSeedTeam']?['id'], 
          'bottomId': s['bottomSeedTeam']?['id'],
          'score': '${s['topSeedWins'] ?? 0}-${s['bottomSeedWins'] ?? 0}',
          'topLogo': s['topSeedTeam']?['logo'] ?? 'empty', 
          'bottomLogo': s['bottomSeedTeam']?['logo'] ?? 'empty',
          'seriesAbbrev': s['seriesAbbrev'],
          'seriesLetter' : s['seriesLetter'] 
        };
      }).toList();
      return series;
    } else {
      throw Exception('Failed to load series data');
    }
  }


 Future<List<Map<String, dynamic>>> fetchGamesAndDetails(String seriesLetter) async {
  final response = await http.get(Uri.parse('$seriesDetailUrl/$seriesLetter/'));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    List<Map<String, dynamic>> games = (data['games'] as List).map<Map<String, dynamic>>((g) {
      return {
        'gameId': g['id'],
        'home': g['homeTeam']?['abbrev'] ?? '???',
        'away': g['awayTeam']?['abbrev'] ?? '???',
        'homeId': g['homeTeam']?['id'] ?? '???',
        'awayId': g['awayTeam']?['id'],
        'score': g['homeTeam']?['score'] != null && g['awayTeam']?['score'] != null ? '${g['homeTeam']['score']}-${g['awayTeam']['score']}' : formatDate(g['startTimeUTC']),
        'startTime': g['startTimeUTC']
      };
    }).toList();

    // Debug: Print the number of games processed
    

    List<Future<Map<String, dynamic>>> detailsFutures = games.map((game) {
      return ApiService().fetchGameDetails(game['gameId']);
    }).toList();

    List<Map<String, dynamic>> additionalDetails = await Future.wait(detailsFutures);

    // Combine details with games
    for (int i = 0; i < games.length; i++) {
      games[i]['details'] = additionalDetails[i]['teamGameStats'];  // Access the 'teamGameStats' key
      // Debug: Print each game detail added
    }

    return games;
  } else {
    throw Exception('Failed to load series data');
  }
}



Future<Map<String, dynamic>> fetchGameDetails(int gameId) async {
  final response = await http.get(Uri.parse('$gameDetailUrl/$gameId/landing'));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // Ensure it always returns a map.
    return {
      'teamGameStats': data['summary']?['teamGameStats'] ?? {}
    };
  } else {
    throw Exception('Failed to fetch details for game $gameId');
  }
}


}
 
 String formatDate(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  // Format the date as mm/dd/yyyy
  return '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}';
}
