import 'package:flutter/material.dart';
import 'package:how_is_moon/component/clock.dart';
import 'package:how_is_moon/screens/earth.dart';
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
  bool play = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1970, 1, 7),
        lastDate: new DateTime(2200));

    if (newDate != null && newDate != _date) {
      // calculateMoonPhase(newDate);
      setState(() {
        _date = newDate;
        brNav = new DateFormat('yyyy-MM-dd').format(newDate).toString();
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
            child: FlareActor(
              "assets/Moon.flr",
              fit: BoxFit.contain,
              animation: play ? 'moonPhrase' : 'idle',
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
