import 'package:flutter/material.dart';
import 'package:tasty/model/Product.dart';
import 'package:tasty/cartPage.dart';
import 'package:tasty/vista1.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:tasty/database/db.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/login.dart';
class PromotionDetailsPage extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final String subtitle;
  final String description;
  final int cantidad;
  final int userProfileId;


  const PromotionDetailsPage({
    Key? key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.description,
    required this.id,
    required this.cantidad,
    required this.userProfileId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Color(0xff3f1602),
              ),
              onPressed:(){Scaffold.of(context).openEndDrawer();})
        ],

      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFFDFBEF),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFEFBC3D),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart ,
                color: Colors.black,
              ),
              title: Text(
                'Carrito',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage()),);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () {

              },
            ),

            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text(
                'Exit',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child:
                    RoundedBackgroundText(
                      title,
                      style: const TextStyle(color:Color(0xffefbc3d),fontSize: 40,fontWeight: FontWeight.bold),
                      backgroundColor: Color(0xfffdfbef),

                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Precio: '+subtitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: FutureBuilder<int>(
                      future: service.getPromotionQuantity(id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final quantity = snapshot.data!;
                          return Text(
                            'Cantidad restante: $quantity',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error al obtener la cantidad');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color(0xff3f1602),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        'Añadir al Carrito',
                        style: TextStyle(
                          color: Color(0xFFFDFBEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await DB().insertarProducto(Product(
                        id: id,
                        title: title,
                        subtitle: subtitle,
                        description: description,
                        image: image,
                        cantidad: cantidad,
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Producto añadido',
                            style: TextStyle(
                              color: Color(0xff3f1602), // Cambia el color de texto a 0xff3f1602
                            ),
                          ),
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Color(0xfffdfbef),
                        ),
                      );
                    },
                  ),


                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color(0xff3f1602)

                    ),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        'Ir a pagar',
                        style: TextStyle(
                          color: Color(0xFFFDFBEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    onPressed: () async{
                      Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage()),);
                    },),


                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color(0xff3f1602)

                    ),
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Text(
                        'Seguir Comprando',
                        style: TextStyle(
                          color: Color(0xFFFDFBEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    onPressed: () async{
                      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
                    },)

                  // ... Otros detalles de la promoción
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
