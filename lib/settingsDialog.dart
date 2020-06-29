import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingDialog extends StatefulWidget {
  final Function(String, dynamic) callback;
  SettingDialog(this.callback);

  @override
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  bool showSat = false;
  bool showAst = false;
  String astAnime = 'flash';

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showSat = prefs.getBool('showSat') ?? false;
      showAst = prefs.getBool('showAst') ?? false;
      astAnime = prefs.getString('astAnime') ?? 'flash';
    });
  }

  setSharedPref(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key == "astAnime")
      prefs.setString(key, value);
    else
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
                          widget.callback('showSat', showSat);
                        },
                        secondary: const Icon(Icons.airplanemode_active),
                      ),
                      SwitchListTile(
                        title: const Text('Show Astronaut'),
                        value: showAst,
                        onChanged: (bool value) {
                          // save to shared preferences
                          setSharedPref('showAst', value);
                          setState(() {
                            showAst = value;
                          });
                          // modify the value in parent
                          widget.callback('showAst', showAst);
                        },
                        secondary: const Icon(Icons.accessibility_new),
                      ),
                      ListTile(
                        leading: Icon(Icons.touch_app),
                        title: Text("Astronaut when tap"),
                        enabled: showAst,
                        trailing: DropdownButton<String>(
                          value: astAnime,
                          onChanged: showAst
                              ? (String value) {
                                  setSharedPref('astAnime', value);
                                  setState(() {
                                    astAnime = value;
                                  });
                                  widget.callback('astAnime', astAnime);
                                }
                              : null,
                          items: <String>['flash', 'float', 'phone', 'walk']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
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
