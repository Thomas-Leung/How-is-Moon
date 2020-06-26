import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Astronaut extends StatefulWidget {
  @override
  _AstronautState createState() => _AstronautState();
}

class _AstronautState extends State<Astronaut> {
  final List<String> animationList = [
    'idle',
    'flash',
    'phone',
    'float',
    'walk'
  ];
  String astronautAnime = "idle";
  var randomNum = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            var rad = new Random();
            randomNum = rad.nextInt(5);
            print(randomNum);
          });
        },
        child: FlareActor(
          'assets/Astronaut.flr',
          fit: BoxFit.fitWidth,
          animation: animationList[randomNum],
        ),
      ),
    );
  }
}
