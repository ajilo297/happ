import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:happ/views/devices/devices_view_model.dart';
import 'package:happ/widgets/appliance_card.dart';
import 'package:happ/widgets/rounded_card.dart';
import 'package:provider/provider.dart';

class DevicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DevicesViewModel viewModel =
        DevicesViewModel(databaseService: Provider.of(context));
    return BaseView<DevicesViewModel>(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.fetchListOfRunningDevices();
        viewModel.fetchListOfRooms();
      },
      builder: (context, viewModel, _) {
        return getView(context, viewModel);
      },
    );
  }

  Widget getView(BuildContext context, DevicesViewModel viewModel) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            getLinkedDevices(context, viewModel),
            getRoomList(context, viewModel),
            getAppliancesList(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget getLinkedDevices(BuildContext context, DevicesViewModel viewModel) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => viewModel.goBack(context),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All Devices',
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  'Devices linked with Happ',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
              ],
            ),
          ),
        ),
        RoundedCard(
          padding: EdgeInsets.all(0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => viewModel.addDevice(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.add),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }

  Widget getRoomList(BuildContext context, DevicesViewModel viewModel) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.roomList.length,
        itemBuilder: (context, index) {
          RoomModel roomModel = viewModel.roomList.elementAt(index);
          return RoundedCard(
            width: 150,
            child: Center(
              child: Text(roomModel.name),
            ),
          );
        },
      ),
    );
  }

  Widget getAppliancesList(BuildContext context, DevicesViewModel viewModel) {
    return Wrap(
      children: viewModel.runningAppliances.map((appliance) {
        return ApplianceCard(
          appliance,
          onToggle: () => viewModel.toggleAppliance(appliance),
        );
      }).toList(),
    );
  }
}
