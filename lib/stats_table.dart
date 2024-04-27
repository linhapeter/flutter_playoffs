import 'package:flutter/material.dart';

class StatsTable extends StatelessWidget {
  final Map<String, dynamic> game;

  const StatsTable({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(color: Colors.white),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            TableCell(child: Center(child: Text('Stat', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text('Home', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text('Away', style: TextStyle(color: Colors.white, fontSize: 16)))),
          ]),
          TableRow(children: [
            TableCell(child: Center(child: Text('SOG', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][0]['homeValue']?.toString() ?? '20', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][0]['awayValue'].toString() ?? '15', style: TextStyle(color: Colors.white, fontSize: 16)))),
          ]),
          TableRow(children: [
            TableCell(child: Center(child: Text('PIM', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][4]['homeValue'].toString() ?? '10', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][4]['awayValue'].toString() ?? '12', style: TextStyle(color: Colors.white, fontSize: 16)))),
          ]),
          TableRow(children: [
            TableCell(child: Center(child: Text('Hits', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][5]['homeValue'].toString() ?? '10', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][5]['awayValue'].toString() ?? '12', style: TextStyle(color: Colors.white, fontSize: 16)))),
          ]),
          TableRow(children: [
            TableCell(child: Center(child: Text('BS', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][6]['homeValue'].toString() ?? '10', style: TextStyle(color: Colors.white, fontSize: 16)))),
            TableCell(child: Center(child: Text(game['details'][6]['awayValue'].toString() ?? '12', style: TextStyle(color: Colors.white, fontSize: 16)))),
          ]),
        ],
      ),
    );
  }
}
