class User {
  final String id;
  final String name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }

  String getId() {
    return this.id;
  }

  String getName() {
    return this.name;
  }
}