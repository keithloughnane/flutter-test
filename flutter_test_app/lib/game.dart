
import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test_app/world.dart';

abstract class Game {
  void render(Canvas canvas, Size size);

  void setWorld(World world);

  void clicked(double dx, double dy);

  void right() {

  }

  void setUp(BuildContext context);
}