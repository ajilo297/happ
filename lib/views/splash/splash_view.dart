import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashViewModel viewModel = SplashViewModel(
      preferenceService: Provider.of<PreferenceService>(context),
    );
    return BaseView<SplashViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel, _) => getView(context, viewModel),
      onModelReady: (viewModel) async {
        await viewModel.loadAfterDelay();
        viewModel.navigateToNextScreen(context);
      },
    );
  }

  Widget getView(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }
}
