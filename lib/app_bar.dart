import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/images/nhl-logo.png', height: 40), // Set the height as per your design
          SizedBox(width: 10), // Spacing between the logo and the title
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
      titleSpacing: 0, // Removes the default spacing to the left of the title if needed
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
