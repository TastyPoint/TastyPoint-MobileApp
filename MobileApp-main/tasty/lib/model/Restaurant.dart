import 'package:tasty/model/Product.dart';
class Restaurant {
  int id;
  String name;
  String description;
  String address;
  int rate;
  bool favourite;
  String image;
  List<Product> products; // Nueva lista de productos

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.rate,
    required this.favourite,
    required this.image,
    this.products = const [], // Asigna una lista vacía como valor predeterminado
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'rate': rate,
      'favorite': favourite,
      'image': image,
      'products': products.map((product) => product.toMap()).toList(), // Agrega la lista de productos al mapa
    };
  }

  factory Restaurant.forMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: map['address'],
      rate: map['rate'],
      favourite: map['favorite'],
      image: map['image'],
      products: (map['products'] as List<Map<String, dynamic>>)
          .map((productMap) => Product.forMap(productMap))
          .toList(), // Asigna los productos desde el mapa
    );
  }
}

