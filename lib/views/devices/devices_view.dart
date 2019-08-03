import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/views/devices/devices_view_model.dart';

class DevicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DevicesViewModel viewModel = DevicesViewModel();
    return BaseView<DevicesViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel, _) {
        return getView(context, viewModel);
      },
    );
  }

  Widget getView(BuildContext context, DevicesViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Text('Devices'),
      ),
    );
  }
}
