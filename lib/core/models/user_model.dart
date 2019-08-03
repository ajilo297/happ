class UserModel {
  String name;

  UserModel({
    this.name,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => new UserModel(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
      };
}
