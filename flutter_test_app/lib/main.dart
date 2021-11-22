import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/custom_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //_MyPageState createState() => _MyPageState();

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

// class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   World world = new World(0.0, 0.0);
//   late final DateTime _initialTime = DateTime.now();
//   double previous = 0.0;
//   double pointerx;
//   double pointery;
//
//   double get currentTime =>
//       DateTime
//           .now()
//           .difference(_initialTime)
//           .inMilliseconds / 1000.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTapDown: pointerUpdate,
//         onTapUp: pointerUpdate,
//         onVerticalDragUpdate: pointerUpdate,
//         onHorizontalDragUpdate: pointerUpdate,
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (BuildContext contex, Widget child) {
//             var curr = currentTime;
//             var dt = curr - previous;
//             previous = curr;
//
//             return CustomPaint(
//               size: MediaQuery
//                   .of(context)
//                   .size,
//               painter: MyGame(world, pointerx, pointery, dt),
//               child: Center(
//                 child: Text('This is your UI'),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     previous = currentTime;
//     _controller = new AnimationController(
//         vsync: this, duration: const Duration(seconds: 1))
//       ..repeat();
//     _animation = new Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//   }
//
//   void pointerUpdate(details) {
//     pointerx = details.globalPosition.dx;
//     pointery = details.globalPosition.dy;
//   }
// }}

class MyPainter extends StatelessWidget {

  final DateTime _initialTime = DateTime.now();

  double previous = 0.0;

  double get currentTime =>
      DateTime.now().difference(_initialTime).inMilliseconds / 1000.0;

  late AnimationController _controller;

  late Animation<double> _animation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:

        Builder(
            builder: (BuildContext context) {
              MetaGame meta = MetaGame("WINDY_HILL", context);

              previous = currentTime;
              _controller =  AnimationController(
                  vsync: Scaffold.of(context), duration: const Duration(seconds: 1))
                ..repeat();
              _animation =  Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
              
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);


              return SizedBox.expand(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 10 || details.delta.dx < -10) {
                      // Swiping in right direction.
                      if (details.delta.dx > 0) {
                        print("KLTest RIGHT");
                        meta.right();
                      }

                      // Swiping in left direction.
                      if (details.delta.dx < 0) {
                        print("KLTest LEFT");
                      }
                    }
                  },
                  child: CustomPaint(
                    painter: meta.getView(),
                    child: Container(),
                  ),
                ),
              );


              // return Column(
              //   children: <Widget>[
              //     Expanded(
              //       child: SizedBox.expand(
              //         child: CustomPaint(
              //           painter: MetaGame("WINDY_HILL", context).getView(),
              //           child: Container(),
              //         ),
              //       ),
              //     ),

              //   ],
              // );
            }
        )
    );
  }
}
