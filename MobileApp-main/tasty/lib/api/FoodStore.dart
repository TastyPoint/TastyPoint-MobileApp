class FoodStore{
  int id;
  String name;
  String description;
  String address;
  int rate;
  bool favourite;
  String image;
  int userProfileId; // Nuevo atributo

  FoodStore({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rate,
    required this.favourite,
    required this.image,
    required this.userProfileId, // Incluye el nuevo atributo en el constructor

  });
  static FoodStore objJson(Map<String,dynamic> json){
    return FoodStore(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        address: json['address'] as String,
        rate: json['rate'] as int,
        favourite: json['favorite'] as bool,
        image: json['image'] as String,
      userProfileId: json['userProfile']['id'] as int, // Asigna el ID del userProfile
    );

  }
}