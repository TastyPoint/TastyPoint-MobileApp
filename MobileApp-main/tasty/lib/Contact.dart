import 'package:flutter/material.dart';

class Contacto extends StatelessWidget {
  const Contacto({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE7CF),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Contactate con Tasty Point :D",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¡Envíanos un correo a tastyPoint@email.com!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
