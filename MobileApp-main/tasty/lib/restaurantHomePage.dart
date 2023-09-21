import 'package:flutter/material.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/api/Promotion.dart';
import 'package:tasty/api/Review.dart';
import 'package:tasty/CreatePromotionPage.dart';
import 'package:tasty/EditPromotionPage.dart';
import 'package:tasty/Profile.dart';
import 'package:tasty/Contact.dart';
import 'package:tasty/login.dart';
import 'package:tasty/Configuration.dart';



class RestaurantPage extends StatefulWidget {
  final int userId;

  const RestaurantPage({Key? key, required this.userId}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  Future<List<Promotion>>? _promotionsFuture;
  Future<List<Review>>? _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _promotionsFuture = service.getUserPromotions(widget.userId);
    _reviewsFuture = service.getReviews();
  }

  void _incrementPromotionQuantity(Promotion promotion) {
    setState(() {
      promotion.quantity++; // Incrementa la cantidad de la promoción en 1
    });
  }


  Future<List<Review>> _getReviewsByFoodStoreId(int foodstoreId) async {
    final reviews = await _reviewsFuture;
    if (reviews != null) {
      final filteredReviews = reviews.where((review) => review.foodStoreId == foodstoreId).toList();
      return filteredReviews;
    }
    return [];
  }

  void _navigateToCreatePromotion() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePromotionPage(userId: widget.userId),
      ),
    );

    // Actualiza la lista de promociones
    setState(() {
      _promotionsFuture = service.getUserPromotions(widget.userId);
    });
  }

  void _navigateToEditPromotionAndRefresh(Promotion promotion) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPromotionPage(promotion: promotion),
      ),
    );
    setState(() {
      _promotionsFuture = service.getUserPromotions(widget.userId);
    });
  }

  void _deletePromotion(Promotion promotion) async {
    try {
      await service.deletePromotion(promotion.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promotion deleted.'),
        ),
      );
      setState(() {
        _promotionsFuture = service.getUserPromotions(widget.userId);
      });
    } catch (e) {
      print('Error deleting promotion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete promotion.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Your Products",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff3f1602),
          child: Padding(
            padding: const EdgeInsets.only(top:40.0, left: 10, right: 10, bottom: 30),
            child: Column(
              children: [

                Text("TEN UN MONITO DIA :)", style: TextStyle(
                  color: Color(0xFFEFBC3D),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 285,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(380),
                      image: DecorationImage(
                        image: AssetImage("assets/img/logo.png"),
                      )
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Color(0xFFEFBC3D),

                          ),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => profile(userId: widget.userId),));
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                color: Color(0xff3f1602),
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                // package: 'flutter_credit_card',
                              ),
                            ),
                          )), )

                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Color(0xFFEFBC3D),

                          ),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Exit',
                              style: TextStyle(
                                color: Color(0xff3f1602),
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                // package: 'flutter_credit_card',
                              ),
                            ),
                          )), )

                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Color(0xFFEFBC3D),

                          ),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => Contacto()),);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Contacto',
                              style: TextStyle(
                                color: Color(0xff3f1602),
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                // package: 'flutter_credit_card',
                              ),
                            ),
                          )), )

                  ],
                )




              ],
            ),
          ),
        ),

      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
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
                        return Container(
                          color: Color(0xFFFDFBEF),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Image.network(
                                promotion.image,
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          promotion.title,
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            _navigateToEditPromotionAndRefresh(promotion);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Cantidad aumentada'),
                                              ),
                                            );
                                            _incrementPromotionQuantity(promotion);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deletePromotion(promotion);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No promotions available.');
                  }
                },
              ),
            ),

            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff3f1602),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Review>>(
                future: _getReviewsByFoodStoreId(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final reviews = snapshot.data!;
                    return ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 4),
                                  Text(
                                    'Rating: ${review.rate}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No reviews available.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreatePromotion,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFDFBEF),
      ),
    );
  }
}


