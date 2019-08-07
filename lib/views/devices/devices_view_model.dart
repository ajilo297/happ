import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:happ/core/services/database_service.dart';
import 'package:happ/views/add_devices/add_devices_view.dart';

class DevicesViewModel extends BaseViewModel {
  List<ApplianceModel> _runningAppliances = [];
  List<RoomModel> _roomList = [];
  DatabaseService _databaseService;

  bool _updated = false;

  DevicesViewModel({
    @required DatabaseService databaseService,
  }) : this._databaseService = databaseService {
    log.i('constructor: ');
  }

  List<ApplianceModel> get runningAppliances => this._runningAppliances;
  set runningAppliances(List<ApplianceModel> runningAppliances) {
    this._runningAppliances = runningAppliances;
    notifyListeners();
  }

  List<RoomModel> get roomList => this._roomList;
  set roomList(List<RoomModel> roomList) {
    this._roomList = roomList;
    notifyListeners();
  }

  Future fetchListOfRunningDevices() async {
    log.i('fetchListOfRunningDevices');
    busy = true;
    this.runningAppliances = await _databaseService.getRunningAppliances();
    busy = false;
  }

  Future fetchListOfRooms() async {
    log.i('fetchListOfRooms');
    busy = true;
    this.roomList = await _databaseService.getRooms();
    busy = false;
  }

  Future toggleAppliance(ApplianceModel model) async {
    log.i('updateTable: ${model.toMap()}');
    busy = true;
    _databaseService.toggleAppliance(model);
    busy = false;
    await fetchListOfRunningDevices();
    _updated = true;
  }

  void addDevice(BuildContext context) {
    log.i('addDevice');
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => AddDevicesView(),
      ),
    ).then((value) {
      if (value) {
        fetchListOfRunningDevices();
        fetchListOfRooms();
        _updated = true;
      }
    });
  }

  void goBack(BuildContext context) {
    Navigator.pop(context, _updated);
  }
}
