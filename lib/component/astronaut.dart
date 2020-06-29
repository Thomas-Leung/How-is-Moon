import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Astronaut extends StatefulWidget {
  final String astAnime;
  Astronaut(this.astAnime);
  @override
  _AstronautState createState() => _AstronautState();
}

class _AstronautState extends State<Astronaut> {
  bool tap = false;
  var randomNum = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            tap = !tap;
          });
        },
        child: FlareActor(
          'assets/Astronaut.flr',
          fit: BoxFit.fitWidth,
          animation: tap ? widget.astAnime : "idle",
        ),
      ),
    );
  }
}
