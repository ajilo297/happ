import 'package:happ/core/base/base_service.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/core/models/room_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends BaseService {
  static const _ROOM_TABLE = 'ROOM';
  static const _APPLICANCE_TABLE = 'APPLICANCE';

  static const _ID_KEY = 'ID';
  static const _ROOM_ID_KEY = 'ROOM_ID';
  static const _NAME_KEY = 'NAME';
  static const _IS_ON_KEY = 'IS_ON';
  static const _CREATED_AT_KEY = 'CREATED_AT';
  static const _UPDATED_AT_KEY = 'UPDATED_AT';

  Database _database;

  DatabaseService() {
    initialize();
  }

  Future initialize() async {
    _database = await openDatabase(
      'happ_db.db',
      onCreate: (database, version) async {
        await createDatabase(database);
      },
      version: 1,
    );
  }

  Future closeDb() async {
    _database.close();
  }

  Future createDatabase(Database database) async {
    log.i('createDatabase');

    String createRoomQuery = 'CREATE TABLE $_ROOM_TABLE ('
        '$_ID_KEY INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$_NAME_KEY TEXT'
        ')';
    log.d('createDatabase: $createRoomQuery');
    database.execute(createRoomQuery);

    await createRoom(
      RoomModel(name: 'Kitchen'),
      database: database,
    );
    await createRoom(
      RoomModel(name: 'Bedroom 1'),
      database: database,
    );
    await createRoom(
      RoomModel(name: 'Living room'),
      database: database,
    );
    await createRoom(
      RoomModel(name: 'Dining room'),
      database: database,
    );

    String createApplianceQuery = 'CREATE TABLE $_APPLICANCE_TABLE ('
        '$_ID_KEY INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$_ROOM_ID_KEY INTEGER, '
        '$_NAME_KEY TEXT, '
        '$_IS_ON_KEY INTEGER, '
        '$_CREATED_AT_KEY INTEGER, '
        '$_UPDATED_AT_KEY INTEGER'
        ')';
    log.d('createApplianceQuery: $createApplianceQuery');
    database.execute(createApplianceQuery);

    await createAppliance(
      ApplianceModel(
        roomId: 1,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        isOn: true,
        name: 'Refrigerator',
      ),
      database: database,
    );

    await createAppliance(
      ApplianceModel(
        roomId: 2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        isOn: true,
        name: 'Smart Light',
      ),
      database: database,
    );

    await createAppliance(
      ApplianceModel(
        roomId: 2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        isOn: true,
        name: 'Fan',
      ),
      database: database,
    );

    await createAppliance(
      ApplianceModel(
        roomId: 2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        isOn: false,
        name: 'Air Conditioner',
      ),
      database: database,
    );
  }

  Future createAppliance(
    ApplianceModel applianceModel, {
    Database database,
  }) async {
    log.i('createAppliance: ${applianceModel.toMap()}');
    Database db = database ?? _database;
    int newId = await db.insert(_APPLICANCE_TABLE, {
      _ROOM_ID_KEY: applianceModel.roomId,
      _NAME_KEY: applianceModel.name,
      _IS_ON_KEY: applianceModel.isOn ? 1 : 0,
      _CREATED_AT_KEY: applianceModel.createdAt,
      _UPDATED_AT_KEY: applianceModel.updatedAt
    });
    log.i('createAppliance: created at $newId');
  }

  Future createRoom(
    RoomModel roomModel, {
    Database database,
  }) async {
    log.i('createRoom: ${roomModel.toMap()}');
    Database db = database ?? _database;
    int newId = await db.insert(
      _ROOM_TABLE,
      {_NAME_KEY: roomModel.name},
    );
    log.i('createRoom: created at $newId');
  }
}
