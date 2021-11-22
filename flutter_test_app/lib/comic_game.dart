import 'dart:async';
import 'dart:ui';

import 'package:flutter_test_app/world.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class ComicGame extends Game {
     ImageInfo? eyes;
     ImageInfo? hair;
     ImageInfo? face;
     ImageInfo? nose;
     ImageInfo? mouth;
     ImageInfo? fringe;

    var bgPaint = Paint()
        ..color = const Color.fromARGB(120, 0, 0, 0)
        ..style = PaintingStyle.fill;

    var textBgPaint = Paint()
        ..color = const Color.fromARGB(120, 0, 0, 0)
        ..style = PaintingStyle.fill;

    var imagePaint = Paint()
        ..color = const Color.fromARGB(254, 0, 0, 0)
        ..style = PaintingStyle.fill;

    List<SpeechOptions> speechOptions = <SpeechOptions>[];

    

  Size? oldSize;


    
    setupImages(BuildContext context) {
        getImageInfo(context, "hair_1").then((value) => hair = value);
        getImageInfo(context, "face_1").then((value) => face = value);
        getImageInfo(context, "nose_1").then((value) => nose = value);
        getImageInfo(context, "mouth_1").then((value) => mouth = value);
        getImageInfo(context, "eyes_1").then((value) => eyes = value);
        getImageInfo(context, "fringe_1").then((value) => fringe = value);
    }

    Future<ImageInfo> getImageInfo(BuildContext context, String asset) async {
        AssetImage assetImage = AssetImage("assets/$asset.png");
        ImageStream stream =
        assetImage.resolve(createLocalImageConfiguration(context));
        Completer<ImageInfo> completer = Completer();
        stream.addListener(ImageStreamListener((imageInfo, _) {
            return completer.complete(imageInfo);
        }));
        return completer.future;
    }

    @override
    void clicked(double dx, double dy) {
        // TODO: implement clicked
    }



    @override
    void render(Canvas canvas, Size size) {
        setSize(size);
        
        canvas.drawRect(
                Rect.fromLTRB(0, 0, size.width, size.height), bgPaint);

    if (hair != null) {
      canvas.drawImage(hair!.image, Offset(0, 10), imagePaint);
    }
        if (face != null) {
          canvas.drawImage(face!.image, Offset(0, 10), imagePaint);
        }
        if (fringe != null) {
          canvas.drawImage(fringe!.image, Offset(0, 10), imagePaint);
        }
        if (eyes != null) {
          canvas.drawImage(eyes!.image, Offset(0, 70), imagePaint);
        }
        if (nose != null) {
          canvas.drawImage(nose!.image, Offset(0, 120), imagePaint);
        }
        if (mouth != null) {
          canvas.drawImage(mouth!.image, Offset(0, 160), imagePaint);
        }


        drawSpeechOptions(canvas, "Hello", 10, size.height - 90);
        drawSpeechOptions(canvas, "Hello", 10, size.height - 60);
        drawSpeechOptions(canvas, "Bribe", 10, size.height - 30);
        drawSpeechOptions(canvas, "TEST2", 10, size.height - 0);
    }

    @override
    void setWorld(World world) {
        // TODO: implement setWorld
    }

    void drawSpeechOptions(Canvas canvas, String s, double x, double y) {
        canvas.drawRRect(
                RRect.fromLTRBR(
                        x,
                        y,
                        x + 180,
                        y + 25,
                        Radius.zero),
                textBgPaint);

        var textPainter = TextPainter(
                text: TextSpan(text: s),
                textDirection: TextDirection.ltr,
        );

        textPainter.layout(minWidth: 20, maxWidth: 160);
        textPainter.paint(canvas, Offset(x+10, y+10));
    }

  void setSize(Size size) {
        if (size != oldSize) {
            oldSize = size;
            setSpeech(size);
        }
  }

  void setSpeech(Size size) {
      speechOptions.add(SpeechOptions("Hello", 10, size.height - 90));
      speechOptions.add(SpeechOptions( "Hello", 10, size.height - 60));
      speechOptions.add(SpeechOptions("Bribe", 10, size.height - 30));
      speechOptions.add(SpeechOptions("TEST2", 10, size.height - 0));
  }

  @override
  void setUp(BuildContext context) {
    setupImages(context);
  }
}

class SpeechOptions {
  String text;
  late double x1;
  late double y1;
  bool selected = false;
  late double x2;
  late double y2;

  bool isInside(double x, double y) {
    return (x > x1 && x < x2 && y > y1 && y < y2);
  }

  SpeechOptions(this.text, this.x1, this.y1) {
      x2 = x1 + 180;
      y2 = y1 + 25;
  }
}