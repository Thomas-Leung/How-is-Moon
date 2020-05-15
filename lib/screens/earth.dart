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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.keyboard_arrow_down),
                        Text("  Back to Moon  "),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Color(0xFF4A5F72),
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1.0,
                          color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
