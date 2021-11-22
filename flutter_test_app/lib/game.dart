
import 'dart:ui';

import 'package:flutter_test_app/world.dart';

abstract class Game {
  void render(Canvas canvas, Size size);

  void setWorld(World world);

  void clicked(double dx, double dy);

  void right() {

  }
}