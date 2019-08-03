import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/views/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashViewModel viewModel = SplashViewModel();
    return BaseView(
      viewModel: viewModel,
      builder: (context, viewModel, _) => getView(context, viewModel),
    );
  }

  Widget getView(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_screen.png'),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}
