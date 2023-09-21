class Product {
  int id;
  String title;
  String subtitle;
  String description;
  String image;
  int cantidad; // Nuevo atributo "cantidad"

  Product({required this.id, required this.title, required this.subtitle, required this.description, required this.image, required this.cantidad});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'image': image,
      'cantidad': cantidad, // Incluye el atributo "cantidad" en el mapa
    };
  }

  factory Product.forMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      image: map['image'],
      cantidad: map['cantidad'], // Asigna el valor del atributo "cantidad"
    );
  }
}
