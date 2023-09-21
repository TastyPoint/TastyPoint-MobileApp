class Review {
  int id;
  String text;
  int rate;
  int foodStoreId;

  Review({
    required this.id,
    required this.text,
    required this.rate,
    required this.foodStoreId,
  });

  static Review objJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      text: json['text'] as String,
      rate: json['rate'] as int,
      foodStoreId: json['foodStore']['id'] as int,
    );
  }
}
