import 'package:flutter/widgets.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:happ/core/services/database_service.dart';

class DevicesViewModel extends BaseViewModel {
  List<ApplianceModel> _runningAppliances = [];
  List<RoomModel> _roomList = [];
  DatabaseService _databaseService;

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
  }

  void addDevice(BuildContext context) {
    log.i('addDevice');
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
