class UserProfile {
  int id;
  String name;
  String phoneNumber;
  String type;

  UserProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,//se usara este atributo como el email
    required this.type,//se usara este atributo como contraseña
  });



static UserProfile objJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      type: json['type'] as String,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'type': type,
    };
  }
}
