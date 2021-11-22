import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/world.dart';

import 'comic_game.dart';
import 'game.dart';
import 'overworld_game.dart';

class MetaGame extends CustomPainter {
  List<Game> loadedGames = <Game>[];
  late World world;

  Size? size;

  MetaGame(String cityName, BuildContext context) {
    var builder = WorldBuilder();
    builder.setName(cityName);
    world = builder.build();

    loadedGames = <Game>[OverWorldGame(context), ComicGame(context)];

    loadedGames.forEach((element) {
      element.setWorld(world);
    });
  }

  @override
  bool? hitTest(Offset position) {
    print("KLTest hitTest " + position.toString());
    loadedGames[0].clicked(position.dx, position.dy);

    if (position.dx < 100.0) {
      (loadedGames[0] as OverWorldGame).offsetX -= 15;
    } else if (position.dx > size!.width - 100.0) {
      (loadedGames[0] as OverWorldGame).offsetX += 15;
    }
    //
    // else if (position.dy < 100.0) {
    //   (loadedGames[0] as OverWorldGame).offsetY -= 15;
    // } else if (position.dy > size!.height - 100.0) {
    //   (loadedGames[0] as OverWorldGame).offsetX -= 15;
    // }
    //TODO divide up and pass to subgames
    return super.hitTest(position);
  }


  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    loadedGames[0].render(canvas, size);
    canvas.save();
    canvas.translate(size.width - 200, 0);
    loadedGames[1].render(canvas, Size(size.width - 200, size.height));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  MetaGame getView() {
    return this;
  }

  void right() {
    loadedGames[0].right();
  }
}


