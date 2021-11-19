import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/custom_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Painter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyPainter(),
    );
  }
}

class MyPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:

        Builder(
            builder: (BuildContext context) {
              AnimationController controller = AnimationController(
                duration: const Duration(milliseconds: 100*60*5),
                vsync: Scaffold.of(context),
              );
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
              return Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox.expand(
                      child: CustomPaint(
                        painter: MetaGame("WINDY_HILL", context).getView(),
                        child: Container(),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => controller.forward(from: 0.0)
                  ),
                ],
              );
            }
        )
    );
  }
}
