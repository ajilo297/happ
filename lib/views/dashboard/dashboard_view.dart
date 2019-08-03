import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/dashboard/dashboard_view_model.dart';
import 'package:happ/widgets/rounded_card.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = DashboardViewModel(
      preferenceService: Provider.of<PreferenceService>(context),
    );
    return BaseView<DashboardViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel, _) => _getView(
        context,
        viewModel,
      ),
      onModelReady: (viewModel) {
        viewModel.runTimer();
      },
    );
  }

  Widget _getView(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getNameTimeView(context, viewModel),
              getRunningAppliances(context, viewModel),
              getThemeCard(context, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget getNameTimeView(BuildContext context, DashboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Good ' '${viewModel.timeOfDay}!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 8),
                Text(
                  Provider.of<UserModel>(context)?.name ?? 'User',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  viewModel.time,
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
                Text(
                  viewModel.amPm,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRunningAppliances(
      BuildContext context, DashboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Running Appliances',
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.left,
                ),
              ),
              FlatButton(
                child: Text('See All'),
                onPressed: () => viewModel.seeAllDevices(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getThemeCard(BuildContext context, DashboardViewModel viewModel) {
    return RoundedCard(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewModel.value ? 'Dark Mode' : 'Light Mode',
              ),
            ),
          ),
          Switch(
            activeColor: Theme.of(context).accentColor,
            value: viewModel.value,
            onChanged: viewModel.onChanged,
          ),
        ],
      ),
    );
  }
}
