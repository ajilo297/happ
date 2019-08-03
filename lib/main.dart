import 'package:flutter/material.dart';
import 'package:happ/views/splash/splash_view.dart';

void main() {
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashView(),
    );
  }
}