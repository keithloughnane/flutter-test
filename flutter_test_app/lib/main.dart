import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/custom_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Painter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyPainter(),
    );
  }
}

class MyPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lines'),
        ),
        body:

        Builder(
            builder: (BuildContext context) {
              AnimationController controller = AnimationController(
                duration: Duration(milliseconds: 500),
                vsync: Scaffold.of(context),
              );
              return Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => controller.forward(from: 0.0),
                    child: Text('press me to start the animation'),
                  ),
                  Expanded(
                    child: SizedBox.expand(
                      child: CustomPaint(
                        painter: CustomView(),
                        child: Container(),
                      ),
                    ),
                  )
                ],
              );
            }
        )
    );
  }
}

// FOR PAINTING LINES
// class ShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.teal
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     canvas.drawRRect(RRect.fromLTRBR(100, 100, 200, 200, Radius.zero), paint);

    // final textStyle = TextStyle(
    //   color: Colors.black,
    //   fontSize: 30,
    // );

//     final textSpan = TextSpan(
//       text: 'Hello, world.',
//       style: textStyle,
//     );
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );

//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: size.width,
//     );

//     final xCenter = (size.width - textPainter.width) / 2;
//     final yCenter = (size.height - textPainter.height) / 2;
//     final offset = Offset(xCenter, yCenter);
//     textPainter.paint(canvas, offset);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
