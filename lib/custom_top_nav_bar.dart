import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
class CustomTopNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomTopNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 10),
      child:  Row(
        children: [
          Image.asset('assets/images/nhl-logo.png', height: 40), 
          SizedBox(width: 10),
          Text('PLAYOFFS', style: TextStyle(color: Colors.white, fontSize: 24)),
           if (kIsWeb || Platform.isWindows) ...[
            _buildNavItem('R1', 0),
          _buildNavItem('R2', 1),
          _buildNavItem('CF', 2),
          _buildNavItem('SCF', 3),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
