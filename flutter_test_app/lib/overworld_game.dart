import 'package:flutter/material.dart';

import 'game.dart';
import 'world.dart';

class OverWorldGame extends Game {
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
            (victim.x1 + (victim.width / 2) + world.offsetX) * world.scale,
            (victim.y1 + (victim.height / 2) + world.offsetY) *
                world.scale); //TODO make my own draw methods so I can reuse scale and offset
        canvas.drawCircle(offset, 10, selectedPaint);
      }

      if (fence != null) {
        var offset = Offset((fence.x1 + (fence.width / 2) + world.offsetX) * world.scale,
            (fence.y1 + (fence.height / 2) + world.offsetY) * world.scale);
        canvas.drawCircle(offset, 10, circlePaint);
      }
    }
  }

  void render(Canvas canvas, Size size) {
    world.offsetX += 10;

    for (var building in world.buildings) {
      canvas.drawRRect(
          RRect.fromLTRBR(
              (building.x1 + world.offsetX) * world.scale,
              (building.y1 + world.offsetY) * world.scale,
              (building.x2 + world.offsetX) * world.scale,
              (building.y2 + world.offsetY) * world.scale,
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
        maxWidth: (building.x2 - building.x1) * world.scale,
      );

      final offset = Offset(
          (building.x1 + world.offsetX) * world.scale, (building.y1 + world.offsetY) * world.scale);

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
        world.buildings, (x - world.offsetX) / world.scale, (y - world.offsetY) / world.scale);


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

  @override
  void right() {
    // TODO: implement right
    world.offsetX += 10;
  }

  @override
  void setUp(BuildContext context) {
    // TODO: implement setUp
  }
}


