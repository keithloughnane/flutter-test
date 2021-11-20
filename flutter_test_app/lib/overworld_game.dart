import 'package:flutter/material.dart';

import 'game.dart';
import 'world.dart';

class OverWorldGame extends Game {
  OverWorldGame(BuildContext context) {

  }

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

  void showCrimeDetails(Canvas canvas, Crime? crime) {
    if (crime != null) {
      //print("KLTest victim = " + crime.victim.toString());

      var victim = getBuildingFromPerson(crime.victim);

      //print("KLTest victim building = " + victim.toString());

      var fence = getBuildingFromPerson(crime.fence);

      if (victim != null) {
        var offset = Offset(
            (victim.x1 + (victim.width / 2) + offsetX) * scale,
            (victim.y1 + (victim.height / 2) + offsetY) *
                scale); //TODO make my own draw methods so I can reuse scale and offset
        canvas.drawCircle(offset, 10, selectedPaint);
      }

      if (fence != null) {
        var offset = Offset((fence.x1 + (fence.width / 2) + offsetX) * scale,
            (fence.y1 + (fence.height / 2) + offsetY) * scale);
        canvas.drawCircle(offset, 10, circlePaint);
      }
    }
  }

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
          (building.x1 + offsetX) * scale, (building.y1 + offsetY) * scale);

      textPainter.paint(canvas, offset);

      // print("KLTest Crimes: " + world.crimes.toString());
      // if (world.crimes != null && world.crimes!.isNotEmpty) {
      //   showCrimeDetails(canvas, world.crimes![0]);
      // }

      for (var crime in world.crimes!) {
        showCrimeDetails(canvas, crime);
      }
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

  Building? getBuildingFromPerson(Person? victim) {
    Building? result;
    world.buildings.forEach((building) {
      if (building.occupants.contains(victim)) {
        result = building;
        return;
      }
    });

    return result;
  }
}


