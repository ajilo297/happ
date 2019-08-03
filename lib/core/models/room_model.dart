class RoomModel {
  int id;
  String name;

  RoomModel({
    this.id,
    this.name,
  });

  factory RoomModel.fromMap(Map<String, dynamic> json) => RoomModel(
        id: json["ID"] == null ? null : json["ID"],
        name: json["NAME"] == null ? null : json["NAME"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id == null ? null : id,
        "NAME": name == null ? null : name,
      };
}
