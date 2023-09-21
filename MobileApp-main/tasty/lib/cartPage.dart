import 'package:flutter/material.dart';
import 'package:tasty/model/Product.dart';
import 'package:tasty/database/db.dart';
import 'package:tasty/payment.dart';
import 'package:tasty/api/Service.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Product>> lista;

  @override
  void initState() {
    super.initState();
    DB().initializaDB().whenComplete(() async {
      setState(() {
        lista = DB().listAll();
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          'Carrito',
          style: TextStyle(
            fontSize: 26,
            color: Color(0xFF3F1602),
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: lista,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final items = snapshot.data ?? <Product>[];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.redAccent,
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(items[index].id),
                  onDismissed: (DismissDirection direction) async {
                    await DB().deleteProductos(items[index].id);
                    setState(() {
                      items.remove(items[index]);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(items[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].title,
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Precio: S/.' +
                                      (int.parse(items[index].subtitle) *
                                          items[index].cantidad)
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Cantidad: ' + items[index].cantidad.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async{

                                  await DB().insertarProducto(items[index]);
                                  setState(() {
                                    lista = DB().listAll();
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle_outlined,
                                  size: 30,
                                  color: Color(0xFF3F1602),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async{
                                  await DB().deleteProducto(items[index].id);
                                  setState(() {
                                    lista = DB().listAll();
                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle_outlined,
                                  size: 30,
                                  color: Color(0xFF3F1602),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),

                );
              },

            );

          }
        },


      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Color(0xFF3F1602),
          ),
          onPressed: () async {
            final List<Product> items = await lista; // Obtener la lista de productos del FutureBuilder

            for (var item in items) { // Iterar sobre cada item en la lista
              final productFromAPI = await service.getPromotion(item.id); // Obtener el producto correspondiente del API
              if (item.cantidad >= productFromAPI.quantity) { // Comparar las cantidades
                // La cantidad del item en la lista es mayor que la cantidad del producto en el API
                await service.deletePromotion(item.id);

              }
              else{await service.reducePromotionQuantity(item.id, item.cantidad);}
            }
            await DB().deleteAllProducts();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditCardPage()),
            );
          },


          child: Text(
            'Realizar Pedido',
            style: TextStyle(
              color: Color(0xFFFDFBEF),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

