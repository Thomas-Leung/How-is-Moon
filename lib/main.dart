import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:how_is_moon/component/clock.dart';
import 'package:how_is_moon/flare_controller.dart';
import 'package:how_is_moon/screens/earth.dart';
import 'package:how_is_moon/moon.dart';
import 'package:how_is_moon/tracking_input.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';

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

  @override
  void initState() {
    super.initState();
    _flareController = AnimationControls();
  }

  void _incrementMoon(int amount) {
    currentMoonPhase = amount;
    double diff = currentMoonPhase / selectedMoon;
    _flareController.updateMoonPhase(diff);
  }

  void _resetMoon() {
    currentMoonPhase = 0;
    _flareController.resetMoonPhase();
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
        print("_date: " +
            DateTime.now().toString() +
            " moon: " +
            moonDay.toString());
        if (DateFormat('yyyy-MM-dd').format(newDate) ==
            DateFormat('yyyy-MM-dd').format(DateTime.now()))
          brNav = "Today's Moon";
        else
          brNav = new DateFormat('yyyy-MM-dd').format(newDate).toString();
        _incrementMoon(moonDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          child: Column(
        children: <Widget>[
          Clock(),
          Container(
            height: 350,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FlareActor("assets/Moon.flr",
                    controller: _flareController,
                    fit: BoxFit.contain,
                    animation: 'idle',
                    artboard: "Artboard"),
                Container(child: Text('Hello')),
              ],
            ),
          ),
        ],
      )),
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
}
