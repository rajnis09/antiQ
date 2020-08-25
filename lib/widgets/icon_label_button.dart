import 'package:flutter/material.dart';

class IconLabelButton extends StatelessWidget {
  const IconLabelButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onPressed,
    this.color = Colors.black,
    this.splashColor = Colors.transparent,
  }) : assert(icon != null || label != null);

  final Color splashColor;
  final Function onPressed;
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      height: 50,
      splashColor: splashColor,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
      ),
      label: Text(
        label ?? '',
        style: TextStyle(color: color),
      ),
    );
  }
}
