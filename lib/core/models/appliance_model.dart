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
        id: json["id"] == null ? null : json["id"],
        roomId: json["room_id"] == null ? null : json["room_id"],
        name: json["name"] == null ? null : json["name"],
        isOn: json["isOn"] == null ? null : json["isOn"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "room_id": roomId == null ? null : roomId,
        "name": name == null ? null : name,
        "isOn": isOn == null ? null : isOn,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
