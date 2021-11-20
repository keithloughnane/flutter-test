import 'dart:async';
import 'dart:ui';

import 'package:flutter_test_app/world.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class ComicGame extends Game {
    late ImageInfo eyes;
    late ImageInfo hair;
    late ImageInfo face;
    late ImageInfo nose;
    late ImageInfo mouth;
    late ImageInfo fringe;

    ComicGame(BuildContext context) {
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

    var selectedPaint = Paint()
    ..color = const Color.fromARGB(254, 254, 0, 0)
    ..style = PaintingStyle.fill;

    @override
    void render(Canvas canvas, Size size) {
        canvas.drawRect(
                Rect.fromLTRB(0, 0, size.width, size.height), selectedPaint);

        canvas.drawImage(hair.image, Offset(0, 0), selectedPaint);
        canvas.drawImage(face.image, Offset(0, 0), selectedPaint);
        canvas.drawImage(fringe.image, Offset(0, 000), selectedPaint);
        canvas.drawImage(eyes.image, Offset(0, 100), selectedPaint);
        canvas.drawImage(nose.image, Offset(0, 200), selectedPaint);
        canvas.drawImage(mouth.image, Offset(0, 300), selectedPaint);

        drawSpeechOptions(canvas, "TEST");




    }

    @override
    void setWorld(World world) {
        // TODO: implement setWorld
    }

    void drawSpeechOptions(Canvas canvas, String s) {
        canvas.drawRRect(
                RRect.fromLTRBR(
                        0,
                        0,
                        150,
                        50,
                        Radius.zero),
                selectedPaint);

        final textSpan = TextSpan(
                text: s,
        );

        var textPainter = TextPainter(
                text: textSpan,
                textDirection: TextDirection.ltr,
        );

        textPainter.layout(
                minWidth: 30,
        maxWidth: 100,
        );

        final offset = Offset(
                0, 0);

        textPainter.paint(canvas, offset);

    }
}