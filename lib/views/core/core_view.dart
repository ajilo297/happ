import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:happ/views/core/core_view_model.dart';
import 'package:happ/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

class CoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CoreViewModel viewModel = CoreViewModel();
    return BaseView(
      viewModel: viewModel,
      builder: (context, viewModel, _) => _getView(context, viewModel),
    );
  }

  Widget _getView(BuildContext context, CoreViewModel viewModel) {
    return Theme(
      data: () {
        switch (Provider.of<ThemeVariant>(context).variant) {
          case Variant.dark:
            return ThemeData.dark();
          case Variant.light:
            return ThemeData.light();
          default:
            return ThemeData.dark();
        }
      }(),
      child: SplashView(),
    );
  }
}
