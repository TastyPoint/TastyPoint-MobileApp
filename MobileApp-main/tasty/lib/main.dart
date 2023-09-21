import 'package:flutter/material.dart';
import 'package:tasty/vista1.dart';
import 'package:tasty/payment.dart';
import 'package:tasty/sucessful.dart';
import 'package:tasty/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: login(),
    );
  }
}