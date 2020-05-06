import 'package:flutter/material.dart';

class EarthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hellllllo'),
      ),
      body: Center(
        child: Hero(
          tag: 'earthIcon',
          child: new Image.asset('assets/earth.png'),
        ),
      ),
    );
  }
}
