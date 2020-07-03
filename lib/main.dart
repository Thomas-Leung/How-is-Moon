import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_is_moon/component/astronaut.dart';
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

class _State extends State<MainPage> with SingleTickerProviderStateMixin {
  DateTime _date = new DateTime.now();
  String brNav = "Today's Moon";

  AnimationControls _flareController;
  AnimationController _flutterController;

  int currentMoonPhase = 0;
  int selectedMoon = 29;
  bool tapSat = false;
  bool showSat = false;
  bool showAst = false;
  bool showClock = true;
  DateTime newDate = DateTime.now();
  double diff;
  double _scale;
  String astAnime;

  @override
  void initState() {
    super.initState();
    _flareController = AnimationControls();
    int moonDay = Moon().calculateMoonPhase(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _incrementMoon(moonDay);
    getSharedPref();

    _flutterController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 80),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
  }

  void _incrementMoon(int amount) {
    currentMoonPhase = amount;
    diff = currentMoonPhase / selectedMoon;
    _flareController.updateMoonPhase(diff);
  }

  Future<Null> _selectDate(BuildContext context) async {
    newDate = await showDatePicker(
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
      showAst = prefs.getBool('showAst') ?? false;
      astAnime = prefs.getString('astAnime') ?? "flash";
    });
  }

  // pass this method to settings dialog to
  // change value in parent (main.dart)
  settingCallback(setting, newState) {
    setState(() {
      if (setting == 'showSat')
        showSat = newState;
      else if (setting == 'showAst')
        showAst = newState;
      else
        astAnime = newState;
    });
  }

  void _onTapDown(TapDownDetails details) {
    _flutterController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _flutterController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _flutterController.value;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showClock = !showClock;
                  });
                },
                child: Container(
                  child: showClock ? Clock() : MoonTitle(newDate),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  fit: StackFit.loose,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                      },
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child: FlareActor("assets/Moon.flr",
                            controller: _flareController,
                            fit: BoxFit.contain,
                            animation: 'idle',
                            artboard: "Artboard"),
                      ),
                    ),
                    showAst ? Astronaut(astAnime) : Container(),
                    Positioned(
                      top: -25,
                      right: 20,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          HapticFeedback.heavyImpact();
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
            ),
            Container(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'earthIcon',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EarthPage(diff)));
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
        ),
      ),
    );
  }
}
