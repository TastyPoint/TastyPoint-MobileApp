import 'package:flutter/material.dart';

class configuracion extends StatefulWidget {
  const configuracion({super.key});

  @override
  State<configuracion> createState() => _configuracionState();
}

class _configuracionState extends State<configuracion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Configurame :D",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );
  }
}