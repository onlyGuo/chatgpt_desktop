class Model {

  String displayName;
  String name;

  Model({
    required this.name,
    required this.displayName,
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'name': name,
    'displayName': displayName,
  };

  // fromJson
  Model.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        displayName = json['displayName'];
}
