import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlayoffFAB extends StatelessWidget {
  const PlayoffFAB({Key? key}) : super(key: key);

  void _showPlayoffInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: kIsWeb || Platform.isWindows ? 600 : null,
            child: SingleChildScrollView(
              child: Text(
                "PLAYOFF FORMAT\n\nThe Basics\n16 teams will qualify for the Stanley Cup Playoffs.\n"
                "The format is a set bracket that is largely division-based with wild cards.\n"
                "The top three teams in each division will make up the first 12 teams in the playoffs.\n"
                "The remaining four spots will be filled by the next two highest-placed finishers in each conference, "
                "based on regular-season record and regardless of division.\n"
                "It is possible for one division in each conference to send five teams to the postseason while the other sends just three.\n"
                "Home-ice advantage through the first two rounds goes to the team that placed higher in the regular-season standings.\n"
                "Each of the four rounds is a best-of-7; the first team to win four games advances to the next round.\n\n"
                "The First Round\nThe division winner with the best record in each conference will be matched against the wild-card team with the lesser record\n"
                "The wild card team with the better record will play the other division winner.\n"
                "The teams finishing second and third in each division will meet within the bracket headed by their respective division winners.\n\n"
                "The Second Round\nFirst-round winners within each bracket play one another to determine the four participants in the Conference Finals.\n\n"
                "Conference Finals & Stanley Cup Final\nIn the Conference Finals and Stanley Cup Final, home-ice advantage goes to the team that had the better regular-season record - regardless of the teams' final standing in their respective divisions.",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color fabColor;

    // Check platform and assign color
    if (kIsWeb) {
      fabColor = Colors.orange;  // Color for Web
    } else if (Platform.isAndroid) {
      fabColor = Colors.green;   // Color for Android
    } else if (Platform.isWindows) {
      fabColor = Colors.blue;    // Color for Windows
    } else {
      fabColor = Colors.grey;    // Default color
    }

    return FloatingActionButton(
      onPressed: () => _showPlayoffInfo(context),
      tooltip: 'Playoff Info',
      backgroundColor: fabColor,
      child: const Icon(Icons.info_outline),
    );
  }
}
