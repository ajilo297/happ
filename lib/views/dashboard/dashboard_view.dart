import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/dashboard/dashboard_view_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = DashboardViewModel(
      preferenceService: Provider.of<PreferenceService>(context),
    );
    return BaseView(
      viewModel: viewModel,
      builder: (context, viewModel, _) => _getView(context, viewModel),
    );
  }

  Widget _getView(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Switch(
          value: viewModel.value,
          onChanged: viewModel.onChanged,
        ),
      ),
    );
  }
}
