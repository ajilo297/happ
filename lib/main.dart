import 'package:flutter/material.dart';
import 'package:happ/core/providers.dart';
import 'package:happ/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: SplashView(),
      ),
    );
  }
}
