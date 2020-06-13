import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoonTitle extends StatelessWidget {
  final DateTime newDate;
  MoonTitle(this.newDate);

  final List months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 100, 16, 30),
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 90,
              child: Text(
                DateFormat('yyyy-MM-dd').format(newDate) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now())
                    ? ""
                    : newDate.year.toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Positioned(
              top: 10,
              left: 90,
              child: Text(
                DateFormat('yyyy-MM-dd').format(newDate) ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now())
                    ? "Today's"
                    : "${months[newDate.month]} ${newDate.day.toString()}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 48),
              ),
            ),
            Positioned(
              top: 56,
              right: 100,
              child: Text(
                "Moon",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
