import 'package:flutter/material.dart';
import 'package:happ/core/base/base_view_model.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:happ/core/services/database_service.dart';

class AddDevicesViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();

  List<RoomModel> _roomList = [];
  DatabaseService _databaseService;
  RoomModel _selectedRoom;

  AddDevicesViewModel({@required DatabaseService databaseService})
      : this._databaseService = databaseService;

  List<RoomModel> get roomList => this._roomList;
  set roomList(List<RoomModel> roomList) {
    this._roomList = roomList;
    notifyListeners();
  }

  RoomModel get selectedRoom => this._selectedRoom;
  set selectedRoom(RoomModel roomModel) {
    this._selectedRoom = roomModel;
    notifyListeners();
  }

  Future fetchRooms() async {
    log.i('fetchRooms');
    busy = true;
    this.roomList = await _databaseService.getRooms();
    busy = false;
  }

  void goBack(BuildContext context) {
    log.i('goBack');
    Navigator.pop(context);
  }

  void onRoomChanged(RoomModel roomModel) {
    log.i('onRoomChanged: roomModel: ${roomModel.name}');
    this.selectedRoom = roomModel;
  }

  String validateRoom(RoomModel room) {
    log.i('validateRoom: room: ${room.name}');
    if (room == null) {
      return 'This field is mandatory';
    }
    return null;
  }

  String validateDeviceName(String name) {
    log.i('validateDeviceName: name: $name');
    if (name.isEmpty) {
      return 'Device name cannot be empty';
    }
    if (name.length < 2) {
      return 'Device name should have at least 2 characters';
    }
    return null;
  }

  Future save(BuildContext context) async {
    log.i('save');
    if (!formKey.currentState.validate()) {
      return;
    }
    ApplianceModel model = ApplianceModel(
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      isOn: false,
      name: nameController.text,
      roomId: selectedRoom.id,
    );

    log.i('save: appliance: ${model.toMap()}');

    busy = true;
    await _databaseService.createAppliance(model);
    busy = false;
    Navigator.pop(context, true);
  }
}
