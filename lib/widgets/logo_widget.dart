import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final size;

  const LogoWidget({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splashLogoTag',
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/icons/anitiQNobg.png'),
          ),
        ),
      ),
    );
  }
}
