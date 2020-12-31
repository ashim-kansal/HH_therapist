class Provinces{
  String id;
  String name;

  Provinces({this.id, this.name});

  factory Provinces.fromJson(Map<String, dynamic> json) {
    return Provinces(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

}