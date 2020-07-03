import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Astronaut extends StatefulWidget {
  final String astAnime;
  Astronaut(this.astAnime);
  @override
  _AstronautState createState() => _AstronautState();
}

class _AstronautState extends State<Astronaut> {
  bool _animating = false;
  Timer _timer;
  Map<String, int> _astAnimeTime = {
    "flash": 1,
    "float": 30,
    "phone": 20,
    "walk": 16
  };

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    int _start = _astAnimeTime[widget.astAnime];
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_start < 1) {
          _animating = false;
          timer.cancel();
        } else
          _start--;
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return IgnorePointer(
      ignoring: _animating,
      child: Container(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            HapticFeedback.mediumImpact();
            setState(() {
              _animating = true;
              startTimer();
            });
          },
          child: FlareActor(
            'assets/Astronaut.flr',
            fit: width > height ? BoxFit.contain : BoxFit.fitWidth,
            animation: _animating ? widget.astAnime : "idle",
          ),
        ),
      ),
    );
  }
}
