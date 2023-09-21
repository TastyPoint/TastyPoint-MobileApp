import 'package:flutter/material.dart';
class FoodStoreDetailsPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rating;
  final int promotionId;
  final String promotionTitle;
  final String promotionSubtitle;
  final String promotionDescription;
  final String promotionImage;
  final int userProfileId;

  const FoodStoreDetailsPage({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.promotionId,
    required this.promotionTitle,
    required this.promotionSubtitle,
    required this.promotionDescription,
    required this.promotionImage,
    required this.userProfileId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Store Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Rating: $rating'),
            SizedBox(height: 10),
            Text('Promotion: $promotionTitle'),
            SizedBox(height: 10),
            Text('Description: $promotionDescription'),
            SizedBox(height: 10),
            Image.network(promotionImage),
          ],
        ),
      ),
    );
  }
}
