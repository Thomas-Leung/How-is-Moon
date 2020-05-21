import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  int seconds = 0;
  int playTime = 0;
  String currTime = "How's Moon?";
  String currDate = "";
  bool play = false;
  bool moonMode = false;

  @override
  void initState() {
    super.initState();
    new Timer.periodic(const Duration(seconds: 1), (Timer t) => _clock());
    // calculateMoonPhase(DateTime.now().);
    currDate = DateFormat('EEE d MMM').format(DateTime.now());
  }

  void _clock() {
    setState(() {
      seconds++;
      currTime = DateFormat('kk:mm:ss').format(DateTime.now());
      if (playTime <= seconds && !moonMode) {
        play = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Center(
        child: new Padding(
            padding: EdgeInsets.fromLTRB(16, 100, 16, 30),
            child: Column(
              children: <Widget>[
                new Text(
                  currTime,
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 50),
                ),
                new Text(
                  currDate,
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
                ),
              ],
            )),
      ),
    );
  }
}
