import 'package:flutter/material.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/api/FoodStore.dart';
import 'package:tasty/widgets/FoodstorePromotionWidget.dart';

class BestFoodStoreWidget extends StatefulWidget {
  @override
  _BestFoodStoreWidgetState createState() => _BestFoodStoreWidgetState();
}

class _BestFoodStoreWidgetState extends State<BestFoodStoreWidget> {
  Future<List<FoodStore>>? _foodStoresFuture;

  @override
  void initState() {
    super.initState();
    _foodStoresFuture = service.getFoodStores();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          BestFoodStoreTitle(),
          Expanded(
            child: BestFoodStoreList(foodStoresFuture: _foodStoresFuture),
          ),
        ],
      ),
    );
  }
}

class BestFoodStoreTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Best Food Stores",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff3f1602),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BestFoodStoreTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rating;
  final int foodStoreId;

  const BestFoodStoreTiles({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.foodStoreId,
  }) : super(key: key);

  void _showPromotions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodStorePromotionsWidget(foodStoreId: foodStoreId),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPromotions(context), // Llama al método _showPromotions pasando el contexto
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              boxShadow: [],
            ),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                imageUrl,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              margin: EdgeInsets.all(5),
            ),
          ),
        ],
      ),
    );
  }
}



class BestFoodStoreList extends StatelessWidget {
  final Future<List<FoodStore>>? foodStoresFuture;

  const BestFoodStoreList({Key? key, required this.foodStoresFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FoodStore>>(
      future: foodStoresFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final foodStores = snapshot.data!;
          return ListView.builder(
            itemCount: foodStores.length,
            itemBuilder: (context, index) {
              final foodStore = foodStores[index];
              return BestFoodStoreTiles(
                name: foodStore.name,
                imageUrl: foodStore.image,
                rating: foodStore.rate.toString(),
                foodStoreId: foodStore.id, // Pasa el ID del foodstore aquí
              );
            },
          );
        } else {
          return Text('No se pudo cargar la lista de tiendas de comida.');
        }
      },
    );
  }
}



