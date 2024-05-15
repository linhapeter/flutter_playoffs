import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'stats_table.dart';

class GamesList extends StatelessWidget {
  final List<Map<String, dynamic>> games;
  final Map<String, dynamic> serieData;

  const GamesList({Key? key, required this.games, required this.serieData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600), 
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              color: Colors.grey[850], 
              child: ExpansionTile(
                title: buildGameRow(game, context), 
                children:<Widget>[
                  StatsTable(game: game), 
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildGameRow(Map<String, dynamic> game, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.network(
                game['homeId'] == serieData['topId'] ? serieData['topLogo'] : serieData['bottomLogo'],
                width: 60,
                placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator(),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  game['home'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Text(
          game['score'],
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  game['away'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(width: 10),
              SvgPicture.network(
                game['awayId'] == serieData['bottomId'] ? serieData['bottomLogo'] : serieData['topLogo'],
                width: 60,
                placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
