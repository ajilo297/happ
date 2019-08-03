import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/core/models/user_model.dart';
import 'package:happ/core/services/preferences_service.dart';
import 'package:happ/views/dashboard/dashboard_view_model.dart';
import 'package:happ/widgets/appliance_card.dart';
import 'package:happ/widgets/rounded_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = DashboardViewModel(
      preferenceService: Provider.of<PreferenceService>(context),
      databaseService: Provider.of(context),
    );
    return BaseView<DashboardViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel, _) => _getView(
        context,
        viewModel,
      ),
      onModelReady: (viewModel) {
        viewModel.runTimer();
        viewModel.fetchListOfRunningDevices();
      },
    );
  }

  Widget _getView(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: kToolbarHeight),
            getNameTimeView(context, viewModel),
            getRunningAppliances(context, viewModel),
            getMeterCard(context, viewModel),
            getThemeCard(context, viewModel),
            SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }

  Widget getNameTimeView(BuildContext context, DashboardViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
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
          ),
          getApplianceCardList(context, viewModel),
        ],
      ),
    );
  }

  Widget getApplianceCardList(
    BuildContext context,
    DashboardViewModel viewModel,
  ) {
    if (viewModel.runningAppliances == null ||
        viewModel.runningAppliances.isEmpty) {
      return Center(
        child: Text(
          'No appliances found',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.runningAppliances.length,
        itemBuilder: (context, index) {
          ApplianceModel model = viewModel.runningAppliances.elementAt(index);
          return ApplianceCard(model, onToggle: () {
            viewModel.toggleAppliance(model);
          },);
        },
      ),
    );
  }

  Widget getMeterCard(BuildContext context, DashboardViewModel viewModel) {
    return RoundedCard(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(
                  Icons.dashboard,
                  size: 28,
                  color: Theme.of(context).disabledColor,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'January 19',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Text(
                      'Due in: 6 Days',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    '467',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    'Units',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Bill Amount'),
                ),
                Text('${NumberFormat().simpleCurrencySymbol('INR')} 4654.42'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(child: Text('View Breakdown'), onPressed: () {}),
              RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                child: Text('Pay Bill'),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )
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
