import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:how_is_moon/component/clock.dart';
import 'package:how_is_moon/component/moonTitle.dart';
import 'package:how_is_moon/flare_controller.dart';
import 'package:how_is_moon/screens/earth.dart';
import 'package:how_is_moon/moon.dart';
import 'package:how_is_moon/settingsDialog.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  AnimationControls _flareController;
  final FlareControls plusMoonControl = FlareControls();

  int currentMoonPhase = 0;
  int selectedMoon = 29;
  var tapSat = false;
  var showSat = false;
  var showClock = true;

  @override
  void initState() {
    super.initState();
    _flareController = AnimationControls();
    int moonDay = Moon().calculateMoonPhase(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _incrementMoon(moonDay);
    getSharedPref();
  }

  void _incrementMoon(int amount) {
    currentMoonPhase = amount;
    double diff = currentMoonPhase / selectedMoon;
    _flareController.updateMoonPhase(diff);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1970, 1, 7),
        lastDate: new DateTime(2200));

    if (newDate != null && newDate != _date) {
      int moonDay =
          Moon().calculateMoonPhase(newDate.year, newDate.month, newDate.day);
      setState(() {
        _date = newDate;
        // set pick date button text
        if (DateFormat('yyyy-MM-dd').format(newDate) ==
            DateFormat('yyyy-MM-dd').format(DateTime.now()))
          brNav = "Today's Moon";
        else
          brNav = new DateFormat('yyyy-MM-dd').format(newDate).toString();
        _incrementMoon(moonDay);
      });
    }
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showSat = prefs.getBool('showSat') ?? false;
    });
  }

  // pass this method to settings dialog to
  // change value in parent (main.dart)
  settingCallback(newState) {
    setState(() {
      showSat = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  showClock = !showClock;
                });
              },
              child: Container(
                child: showClock ? Clock() : MoonTitle(),
              ),
            ),
            Container(
              height: 350,
              child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.loose,
                children: <Widget>[
                  FlareActor("assets/Moon.flr",
                      controller: _flareController,
                      fit: BoxFit.contain,
                      animation: 'idle',
                      artboard: "Artboard"),
                  Positioned(
                    top: -25,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tapSat = !tapSat;
                        });
                      },
                      child: showSat
                          ? Container(
                              height: 150,
                              width: 120,
                              child: FlareActor(
                                'assets/Satellite.flr',
                                fit: BoxFit.contain,
                                animation: tapSat ? 'touch' : 'idle',
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
                overflow: Overflow.visible,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'earthIcon',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EarthPage()));
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
                onPressed: () {
                  showDialog(
                    context: context,
                    // (_) is a shorthand for (BuildContext context)
                    builder: (_) => SettingDialog(settingCallback),
                  );
                },
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
}
