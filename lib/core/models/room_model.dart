class RoomModel {
  int id;
  String name;

  RoomModel({
    this.id,
    this.name,
  });

  factory RoomModel.fromMap(Map<String, dynamic> json) => RoomModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
