import 'package:flutter/material.dart';
class GlobalNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _navItem(context, 'R1','/playoffs/R1'),
          _navItem(context, 'R2', '/playoffs/R2'),
          _navItem(context, 'CF', '/playoffs/CF'),
          _navItem(context, 'SCF', '/playoffs/SCF'),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(label, style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
