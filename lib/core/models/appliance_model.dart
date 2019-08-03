class ApplianceModel {
  int id;
  int roomId;
  String name;
  bool isOn;
  int createdAt;
  int updatedAt;

  ApplianceModel({
    this.id,
    this.roomId,
    this.name,
    this.isOn,
    this.createdAt,
    this.updatedAt,
  });

  factory ApplianceModel.fromMap(Map<String, dynamic> json) => ApplianceModel(
        id: json["ID"] == null ? null : json["ID"],
        roomId: json["ROOM_ID"] == null ? null : json["ROOM_ID"],
        name: json["NAME"] == null ? null : json["NAME"],
        isOn: json["IS_ON"] == null ? false : json["IS_ON"] == 1 ? true : false,
        createdAt: json["CREATED_AT"] == null ? null : json["CREATED_AT"],
        updatedAt: json["UPDATED_AT"] == null ? null : json["UPDATED_AT"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id == null ? null : id,
        "ROOM_ID": roomId == null ? null : roomId,
        "NAME": name == null ? null : name,
        "IS_ON": isOn == null ? null : isOn,
        "CREATED_AT": createdAt == null ? null : createdAt,
        "UPDATED_AT": updatedAt == null ? null : updatedAt,
      };
}
