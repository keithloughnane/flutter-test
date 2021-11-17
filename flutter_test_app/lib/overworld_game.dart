import 'package:flutter/material.dart';

import 'world.dart';

class OverWorldGame {
  var offsetX = 0.0;
  var offsetY = 0.0;
  var scale = 5.0;

  late World world;

  static const textStyle = TextStyle(
    color: Colors.black,
    fontSize: 10,
  );

  var circlePaint = Paint()
    ..color = const Color.fromARGB(254, 0, 0, 254)
    ..style = PaintingStyle.stroke;

  var selectedPaint = Paint()
    ..color = const Color.fromARGB(254, 254, 0, 0)
    ..style = PaintingStyle.fill;

  void render(Canvas canvas, Size size) {
    for (var building in world.buildings) {
      canvas.drawRRect(
          RRect.fromLTRBR(
              (building.x1 + offsetX) * scale,
              (building.y1 + offsetY) * scale,
              (building.x2 + offsetX) * scale,
              (building.y2 + offsetY) * scale,
              Radius.zero),
          building.selected ? selectedPaint : circlePaint);

      final textSpan = TextSpan(
        text: building.toString(),
        style: textStyle,
      );

      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: (building.x2 - building.x1) * scale,
      );

      final offset = Offset(
          (building.x1 + offsetX) * scale,
          (building.y1 + offsetY) * scale);

      textPainter.paint(canvas, offset);
    }
  }

  void setWorld(World world) {
    this.world = world;
  }

  void clicked(double x, double y) {
    findSelectedBuilding(
        world.buildings, (x - offsetX) / scale, (y - offsetY) / scale);
  }

  void findSelectedBuilding(List<Building> buildings, double x, double y) {
    for (var element in buildings) {
        element.setSelected(element.isInside(x, y));
    }
  }
}
