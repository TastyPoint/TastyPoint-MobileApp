class Promotion {
  int id;
  String title;
  String subtitle;
  String description;
  String image;
  int quantity;
  int userProfileId;

  Promotion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.quantity,
    required this.userProfileId,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: json['title'],
      subtitle: json['subTitle'],
      description: json['description'],
      image: json['image'],
      quantity: json['quantity'],
      userProfileId: json['userProfile']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subtitle,
      'description': description,
      'image': image,
      'quantity': quantity,
      'userProfileId': userProfileId,
    };
  }
}
