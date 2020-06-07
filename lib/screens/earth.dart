import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:how_is_moon/flare_controller.dart';

class EarthPage extends StatelessWidget {
  final AnimationControls _flareController = AnimationControls();

  // diff is calculated from the main class basically is
  // currentMoon divided by total moon phrase (approx. 29 days)
  EarthPage(diff) {
    // In our Earth animation, the animation name is the same as
    // the Moon animation, therefore, I used the same controller.
    _flareController.updateMoonPhase(diff);
  }

  @override
  Widget build(BuildContext context) {
    int tapCount = 0;
    return Scaffold(
      backgroundColor: Color.fromRGBO(5, 40, 62, 1.0),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Transform(
              transform: Matrix4.skewY(0)
                ..rotateZ(-3.14 / 5.0)
                ..scale(1.5)
                ..translate(-10.0, 0.0),
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset("assets/spaceBg.svg"),
              ),
            ),
            Hero(
              tag: 'earthIcon',
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    tapCount++;
                    if (tapCount >= 3) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Stop tapping. Earthquake detected from Earth!'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                  },
                  child: FlareActor("assets/Earth.flr",
                      controller: _flareController,
                      fit: BoxFit.contain,
                      animation: 'idleClouds',
                      artboard: "Artboard"),
                ),
              ),
            ),
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
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 28,
                onPressed: () {
                  showDialog(
                    context: context,
                    // (_) is a shorthand for (BuildContext context)
                    builder: (_) => _dialogContent(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogContent(context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        children: <Widget>[
          Text('Facts about the Moon'),
          Text(
              '* This page shows the approximate location of the Moon from the slelcted date.'),
          Table(children: [
            TableRow(children: [Text('item1'), Text('content1')]),
            TableRow(children: [Text('item2'), Text('content2')]),
          ]),
        ],
      ),
    );
  }
}
