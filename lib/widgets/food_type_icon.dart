import 'package:flutter/material.dart';

class FoodTypeIcon extends StatelessWidget {
  FoodTypeIcon({
    @required this.color,
    this.size = 16,
  }) : assert(color != null);

  final double size; // MAX_SIZE = 16
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      height: size,
      width: size,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: color,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }
}
