import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingDialog extends StatefulWidget {
  final Function(bool) callback;
  SettingDialog(this.callback);
  
  @override
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  bool showSat;

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showSat = prefs.getBool('showSat') ?? false;
    });
  }

  setSharedPref(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Card(
        child: Container(
          height: 400,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Setting",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Divider(
                  color: Colors.white38,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SwitchListTile(
                        title: const Text('Show Satellite'),
                        value: showSat,
                        onChanged: (bool value) {
                          // save to shared preferences
                          setSharedPref('showSat', value);
                          setState(() {
                            showSat = value;
                          });
                          // modify the value in parent
                          widget.callback(showSat);
                        },
                        secondary: const Icon(Icons.airplanemode_active),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
