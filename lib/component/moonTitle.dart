import 'package:flutter/material.dart';

class MoonTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TodayTitle();
  }
}

class TodayTitle extends StatelessWidget {
  const TodayTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 100, 16, 30),
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 100,
              child: Text(
                "",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Positioned(
              top: 0,
              left: 90,
              child: Text(
                "Today's",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 48),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 100,
              child: Text(
                "Moon",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
