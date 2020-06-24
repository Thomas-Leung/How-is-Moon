import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Astronaut extends StatefulWidget {
  @override
  _AstronautState createState() => _AstronautState();
}

class _AstronautState extends State<Astronaut> {
  final List<String> animationList = ['idle', 'flash', 'phone'];
  String astronautAnime = "idle";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          var rad = new Random();
          print(rad.nextInt(3));
        },
        child: FlareActor(
          'assets/Astronaut.flr',
          fit: BoxFit.fitWidth,
          animation: 'idle',
        ),
      ),
    );
  }
}
