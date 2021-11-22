import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/world.dart';

import 'comic_game.dart';
import 'game.dart';
import 'overworld_game.dart';

class MetaGame {
  List<Game> loadedGames = <Game>[];
  late World world;

  Size? size;

  MetaGame(String cityName) {
    var builder = WorldBuilder();
    builder.setName(cityName);
    world = builder.build();

    loadedGames = <Game>[OverWorldGame(), ComicGame()];

    loadedGames.forEach((element) {
      element.setWorld(world);
    });
  }

  GameRenderer getView() {
    return GameRenderer(loadedGames);
  }

  void right() {
    loadedGames[0].right();
  }

  MetaGame setUp(BuildContext context) {
    loadedGames.forEach((element) {
      element.setUp(context);
    });

    return this;
  }

  onTapDown(TapDownDetails details) {
       print("KLTest onTapDown " + details.globalPosition.dx.toString());

  }

  onTapUp(TapUpDetails details) {
       print("KLTest onTapUp " + details.globalPosition.dx.toString());

  }

  vDrag(DragUpdateDetails details) {
    print("KLTest vDrag offset = " + details.globalPosition.dx.toString());
    world.offsetY += details.globalPosition.dy;

  }

  hDrag(DragUpdateDetails details) {
    print("KLTest hDrag offset = " + details.globalPosition.dx.toString());
    //world.offsetX + 30;
    world.offsetX += details.globalPosition.dx;
  }
}

class GameRenderer extends CustomPainter {
  List<Game> loadedGames;

  GameRenderer(this.loadedGames);

  @override
  void paint(Canvas canvas, Size size) {
    //print("KLTest paint called");
    //this.size = size;
    loadedGames[0].render(canvas, size);
    canvas.save();
    canvas.translate(size.width - 200, 0);
    loadedGames[1].render(canvas, Size(size.width - 200, size.height));
    canvas.restore();
  }

  // @override
  // bool? hitTest(Offset position) {
  //   print("KLTest hitTest " + position.toString());
  //   //world.offsetY += 30;
  //
  //   loadedGames[0].clicked(position.dx, position.dy);
  //
  //   // if (position.dx < 100.0) {
  //   //   (loadedGames[0] as OverWorldGame).offsetX -= 15;
  //   // } else if (position.dx > size!.width - 100.0) {
  //   //   (loadedGames[0] as OverWorldGame).offsetX += 15;
  //   // }
  //   //
  //   // else if (position.dy < 100.0) {
  //   //   (loadedGames[0] as OverWorldGame).offsetY -= 15;
  //   // } else if (position.dy > size!.height - 100.0) {
  //   //   (loadedGames[0] as OverWorldGame).offsetX -= 15;
  //   // }
  //   //TODO divide up and pass to subgames
  //   return super.hitTest(position);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
