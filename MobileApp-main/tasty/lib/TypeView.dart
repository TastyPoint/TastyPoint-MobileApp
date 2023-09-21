import 'package:flutter/material.dart';
import 'package:tasty/restaurantHomePage.dart';
import 'package:tasty/vista1.dart';
import 'package:tasty/api/UserProfile.dart';
import 'package:tasty/api/Service.dart';


class HomeView extends StatefulWidget {
  final int userId;

  const HomeView({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFBC3D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Text(
              'Selecciona tu tipo de usuario',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantPage(userId: widget.userId)),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF3F1602)),
            ),
            child: Text(
              'Business',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF3F1602)),
            ),
            child: Text(
              'Consumer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
