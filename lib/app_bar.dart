import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  Widget _navItem(BuildContext context, String label, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/nhl-logo.png', height: 40),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white)),
          if (kIsWeb || Platform.isWindows) ...[
            _navItem(context, 'R1', '/playoffs/R1'),
            _navItem(context, 'R2', '/playoffs/R2'),
            _navItem(context, 'CF', '/playoffs/CF'),
            _navItem(context, 'SCF', '/playoffs/SCF'),
          ],
        ],
      ),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
