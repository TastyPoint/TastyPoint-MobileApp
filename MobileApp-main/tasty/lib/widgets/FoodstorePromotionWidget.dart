import 'package:flutter/material.dart';
import 'package:tasty/api/Promotion.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/widgets/PromotionDetailsPage.dart';

class FoodStorePromotionsWidget extends StatefulWidget {
  final int foodStoreId;

  const FoodStorePromotionsWidget({required this.foodStoreId});

  @override
  _FoodStorePromotionsWidgetState createState() =>
      _FoodStorePromotionsWidgetState();
}

class _FoodStorePromotionsWidgetState extends State<FoodStorePromotionsWidget> {
  Future<List<Promotion>>? _promotionsFuture;

  @override
  void initState() {
    super.initState();
    _promotionsFuture = service.getFoodStorePromotions(widget.foodStoreId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Choose your food for today",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xFF3F1602),
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Promotion>>(
          future: _promotionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final promotions = snapshot.data!;
              return ListView.builder(
                itemCount: promotions.length,
                itemBuilder: (context, index) {
                  final promotion = promotions[index];
                  return PopularPromotionTiles(
                    id: promotion.id,
                    title: promotion.title,
                    image: promotion.image,
                    subtitle: promotion.subtitle,
                    description: promotion.description,
                    quantity: promotion.quantity,
                    userProfileId: promotion.userProfileId,
                  );
                },
              );
            } else {
              return Text('No promotions found.');
            }
          },
        ),
      ),
    );
  }
}

class PopularPromotionTiles extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final String subtitle;
  final String description;
  final int quantity;
  final int userProfileId;

  const PopularPromotionTiles({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.description,
    required this.quantity,
    required this.userProfileId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFDFBEF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PromotionDetailsPage(
                id: id,
                title: title,
                image: image,
                subtitle: subtitle,
                description: description,
                cantidad: quantity,
                userProfileId: userProfileId,
              ),
            ),
          );
        },
        child: Container(
          width: 170,
          height: 210,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.topRight,
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 5, top: 5),
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFfae3e2),
                              blurRadius: 25.0,
                              offset: Offset(0.0, 0.75),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Image.network(
                        image,
                        width: 130,
                        height: 140,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(0xFF6e6e71),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xd7fae3e2),
                            blurRadius: 25.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.discount_rounded,
                        color: Color(0xffff8405),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 3, left: 5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 10,
                              color: Color(0xffff8405),
                            ),
                            Icon(
                              Icons.star,
                              size: 10,
                              color: Color(0xffff8405),
                            ),
                            Icon(
                              Icons.star,
                              size: 10,
                              color: Color(0xffff8405),
                            ),
                            Icon(
                              Icons.star,
                              size: 10,
                              color: Color(0xffff8405),
                            ),
                            Icon(
                              Icons.star,
                              size: 10,
                              color: Color(0xFF9b9b9c),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                    child: Text(
                      '\$' + subtitle,
                      style: TextStyle(
                        color: Color(0xFF6e6e71),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
