import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:happ/views/add_devices/add_devices_view_model.dart';
import 'package:happ/widgets/rounded_card.dart';
import 'package:provider/provider.dart';

class AddDevicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddDevicesViewModel viewModel = AddDevicesViewModel(
      databaseService: Provider.of(context),
    );
    return BaseView<AddDevicesViewModel>(
      viewModel: viewModel,
      onModelReady: (viewModel) => viewModel.fetchRooms(),
      builder: (context, viewModel, _) {
        return _getView(context, viewModel);
      },
    );
  }

  Widget _getView(BuildContext context, AddDevicesViewModel viewModel) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              getLinkedDevices(context, viewModel),
              SizedBox(height: 32),
              getRoomDropdown(context, viewModel),
              getDeviceNameWidget(context, viewModel),
              SizedBox(height: 32),
              getSaveButton(context, viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLinkedDevices(BuildContext context, AddDevicesViewModel viewModel) {
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
                  'Add Device',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getRoomDropdown(BuildContext context, AddDevicesViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<RoomModel>(
        value: viewModel.selectedRoom,
        validator: viewModel.validateRoom,
        decoration: InputDecoration(labelText: 'Select Room'),
        items: viewModel.roomList.map((room) {
          return DropdownMenuItem<RoomModel>(
            child: Text(room.name),
            value: room,
          );
        }).toList(),
        onChanged: viewModel.onRoomChanged,
      ),
    );
  }

  Widget getDeviceNameWidget(
    BuildContext context,
    AddDevicesViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: viewModel.nameController,
        decoration: InputDecoration(
          labelText: 'Device name',
        ),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        validator: viewModel.validateDeviceName,
      ),
    );
  }

  Widget getSaveButton(BuildContext context, AddDevicesViewModel viewModel) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: RaisedButton.icon(
              color: Theme.of(context).accentColor,
              colorBrightness: Brightness.dark,
              icon: Icon(Icons.save),
              label: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Save'),
              ),
              onPressed: () => viewModel.save(context),
            ),
          ),
        ),
      ],
    );
  }
}
