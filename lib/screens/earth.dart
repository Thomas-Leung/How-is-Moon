import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class EarthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 40, 62, 1.0),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Stack(
              children: <Widget>[
                Hero(
                    tag: 'earthIcon',
                    child: FlareActor("assets/Earth.flr",
                        fit: BoxFit.contain, animation: 'idle')),
                FlatButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                    label: Text("back to moon")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
