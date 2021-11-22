//Modified Example from https://www.reddit.com/r/dartlang/comments/69luui/minimal_flutter_game_loop/

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/custom_view.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MetaGame meta = MetaGame("Windy Hill");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(meta.setUp(context)),
    );
  }
}

class MyGame extends CustomPainter {
  final World world;
  final double x;
  final double y;
  final double t;

  MyGame(this.world, this.x, this.y, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    world.input(x, y);
    world.update(t);
    world.render(t, canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyPage extends StatefulWidget {
  MetaGame meta;

  MyPage(this.meta);

  _MyPageState createState() => _MyPageState(meta);
}

class World {
  var _turn = 0.0;
  double _x;
  double _y;

  World(this._x, this._y);

  void input(double x, double y) {
    _x = x;
    _y = y;
  }

  void render(double t, Canvas canvas) {
    var tau = math.pi * 2;

    canvas.drawPaint(new Paint()..color = new Color(0xff880000));
    canvas.save();
    canvas.translate(_x, _y);
    canvas.rotate(tau * _turn);
    var white = new Paint()..color = new Color(0xffffffff);
    var size = 200.0;
    canvas.drawRect(new Rect.fromLTWH(-size / 2, -size / 2, size, size), white);
    canvas.restore();
  }

  void update(double t) {
    var rotationsPerSecond = 0.25;
    _turn += t * rotationsPerSecond;
  }
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  World world = World(0.0, 0.0);
  final DateTime _initialTime = DateTime.now();
  double previous = 0.0;
  double pointerx = 0.0;
  double pointery = 0.0;

  MetaGame meta;

  _MyPageState(this.meta);
  double get currentTime =>
      DateTime.now().difference(_initialTime).inMilliseconds / 1000.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: meta.onTapDown,
        onTapUp: meta.onTapUp,
        onVerticalDragUpdate: meta.vDrag,
        onHorizontalDragUpdate: meta.hDrag,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            var curr = currentTime;
            var dt = curr - previous;
            previous = curr;



            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: meta.getView(),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    previous = currentTime;
    _controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
    _animation = new Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }
}
