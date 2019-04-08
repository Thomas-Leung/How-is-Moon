import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MainPage> {
  DateTime _date = new DateTime.now();
  String brNav = "Today's Moon";
  String currTime = "How's Moon?";
  String currDate = "";
  bool play = false;
  bool moonMode = false;
  int seconds = 0;
  int playTime = 0;

  @override
  void initState() {
    super.initState();
    new Timer.periodic(const Duration(seconds: 1), (Timer t) => _clock());
    calculateMoonPhase(DateTime.now());
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1800),
        lastDate: new DateTime(2200));

    if (newDate != null && newDate != _date) {
      calculateMoonPhase(newDate);
      setState(() {
        _date = newDate;
        brNav = new DateFormat('yyyy-MM-dd').format(newDate).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(5, 40, 62, 1.0),
          child: Column(
            children: <Widget>[
              Center(
                child: new Padding(
                    padding: EdgeInsets.fromLTRB(16, 100, 16, 30),
                    child: Column(
                      children: <Widget>[
                        new Text(
                          currTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 50),
                        ),
                        new Text(
                          currDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 20),
                        ),
                      ],
                    )),
              ),
              Container(
                height: 350,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      moonMode = !moonMode;
                      play = !play;
                    });
                  },
                  child: FlareActor(
                    "assets/Moon.flr",
                    fit: BoxFit.contain,
                    animation: play ? 'moonPhrase' : 'idle',
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          calculateMoonPhase(DateTime.now());
          brNav = "Today's Moon";
        },
        backgroundColor: Color.fromRGBO(5, 40, 62, 1.0),
        child: new Image.asset('assets/earth.png'),
      ),
      backgroundColor: Color.fromRGBO(5, 40, 62, 1.0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: new Text("How's Moon in: "),
                onPressed: () {},
              ),
              FlatButton(
                child: new Text(brNav),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ],
          )),
    );
  }

  calculateMoonPhase(DateTime date) {
    moonMode = false;
    int year = int.parse(new DateFormat('yyyy').format(date));
    int month = int.parse(new DateFormat('MM').format(date));
    int day = int.parse(new DateFormat('dd').format(date));
    // Moon Phase Formular
    if (month == 1 || month == 2) {
      month += 12;
      year--;
    }
    var A = year ~/ 100;
    var B = A ~/ 4;
    var C = 2 - A + B;
    var D = (365.25 * (year + 4716)).toInt();
    var E = (30.6001 * (month + 1)).toInt();
    var julianDay = C + day + D + E - 1524.5;
    var daysSinceNew = julianDay - 2451549.5;
    var newMoons = daysSinceNew / 29.53;
    var newMoonsD = newMoons - newMoons.toInt();
    var daysM = newMoonsD * 29.53;
    seconds = 0;
    playTime = (daysM / 29.53 * 8).round();
    setState(() {
      play = true;
    });
  }
}
