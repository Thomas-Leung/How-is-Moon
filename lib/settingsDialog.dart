import 'package:flutter/material.dart';

class SettingDialog extends StatefulWidget {
  @override
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 400,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Setting",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Divider(
                  color: Colors.white38,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
