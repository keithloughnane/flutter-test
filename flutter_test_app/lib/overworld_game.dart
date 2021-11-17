import 'package:flutter/material.dart';

import 'world.dart';

class OverWorldGame {
  var offsetX = 0.0;
  var offsetY = 0.0;
  var scale = 3.0;

  late World world;

  void render(Canvas canvas, Size size) {
    var circlePaint = Paint()
      ..color = Color.fromARGB(254, 0, 0, 254)
      ..style = PaintingStyle.fill;

    var selectedPaint = Paint()
      ..color = Color.fromARGB(254, 254, 0, 0)
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    final xCenter = 100.0;
    final yCenter = 100.0;

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
        maxWidth: size.width,
      );

      final offset = Offset(
          (building.x1 + offsetX) * scale, (building.y1 + offsetY) * scale);
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
    buildings.forEach((element) {
      if (element.isInside(x, y)) {
        element.setSelected(true);
      }
    });
  }
}
