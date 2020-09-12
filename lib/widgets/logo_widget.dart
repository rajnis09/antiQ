import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final size;

  const LogoWidget({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final siz = size ?? 160.0;
    return Hero(
      tag: 'splashLogoTag',
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(siz / 2)),
        child: Container(
          height: siz,
          width: siz,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/anitiQNobg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomCirclePainter extends CustomPainter {
//   CustomCirclePainter({
//     this.backgroundColor,
//   });

//   final Color backgroundColor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = backgroundColor
//       ..strokeWidth = 10
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke;
//     Path path = Path();
//     path.addOval(Rect.fromCircle(
//         center: size.center(Offset.zero), radius: size.width / 2.0 + 13));

//     canvas.drawShadow(path, Colors.black, 10.0, true);
//     canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
//   }

//   @override
//   bool shouldRepaint(CustomCirclePainter old) {
//     return true;
//   }
// }
