import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'flare_controller.dart';

// FOR REFERENCE ONLY, NO USE FOR NOW.
class TrackingInput extends StatefulWidget {
  @override
  _TrackingInputState createState() => _TrackingInputState();
}

class _TrackingInputState extends State<TrackingInput> {
  late AnimationControls _flareController;

  int currentMoonPhase = 0;
  int selectedMoon = 29;

  @override
  void initState() {
    super.initState();
    _flareController = AnimationControls();
  }

  void _incrementMoon() {
    currentMoonPhase++;

    double diff = currentMoonPhase / selectedMoon;
    _flareController.updateMoonPhase(diff);
  }

  void _resetMoon() {
    currentMoonPhase = 0;
    _flareController.resetMoonPhase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(93, 93, 93, 1),
      body: Container(
        color: const Color.fromRGBO(93, 93, 93, 1),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FlareActor(
              "assets/Moon.flr",
              controller: _flareController,
              fit: BoxFit.contain,
              animation: 'idle',
              artboard: "Artboard",
            ),
            Column(
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  onPressed: _incrementMoon,
                ),
                TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('reset'),
                  onPressed: _resetMoon,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
