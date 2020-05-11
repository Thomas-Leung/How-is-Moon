import 'dart:math';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

class AnimationControls extends FlareController {
  ActorAnimation _moonAnimation;

  double _moonPhase = 0.00;
  double _currentPhase = 0;

  double _smoothTime = 5;

  @override
  void initialize(FlutterActorArtboard artboard) {
    // Artboard and moonPhase refers to the elements defined in Rive.
    // check if it is the right artboard and get the animation you need
    if (artboard.name.compareTo("Artboard") == 0) {
      _moonAnimation = artboard.getAnimation('moonPhase');
    }
  }

  @override
  void setViewTransform(Mat2D artboard) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (artboard.name.compareTo("Artboard") == 0) {
      _currentPhase +=
          (_moonPhase - _currentPhase) * min(1, elapsed * _smoothTime);
      _moonAnimation.apply(
          _currentPhase * _moonAnimation.duration, artboard, 1);
    }
    return true;
  }

  void updateMoonPhase(double amount) {
    _moonPhase = amount;
  }

  void resetMoonPhase() {
    _moonPhase = 0;
  }
}
