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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: 250,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            top: width > height ? 18 : 70,
            left: 30,
            child: Text(
              DateFormat('yyyy-MM-dd').format(newDate) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())
                  ? ""
                  : newDate.year.toString(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Positioned(
            top: width > height ? 28 : 80,
            left: 30,
            child: Text(
              DateFormat('yyyy-MM-dd').format(newDate) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())
                  ? "Today's"
                  : "${months[newDate.month]} ${newDate.day.toString()}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 48),
            ),
          ),
          Positioned(
            top: width > height ? 73 : 125,
            left: 120,
            child: Text(
              "Moon",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
