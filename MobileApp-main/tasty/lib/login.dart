import 'package:flutter/material.dart';
import 'package:tasty/signin.dart';
import 'package:tasty/restaurantHomePage.dart';
import 'package:tasty/TypeView.dart';
import 'package:http/http.dart' as http;
import 'package:tasty/api/UserProfile.dart';
import 'package:tasty/api/listUsers.dart';
import 'package:tasty/api/Service.dart';
import 'dart:convert';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Choose your food for today :D",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 16,
          ),
        ),



      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFFDFBEF),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: Color(0xff3f1602)

                          ),
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFFFDFBEF),
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                // package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => login()),);
                          },

                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: Color(0xff414141)

                          ),
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFFFDFBEF),
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                // package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => signin()),);
                          },

                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3f1602),
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ingrese usuario",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3f1602),
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ingrese contraseña",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Forgot your password?",
                    style: TextStyle(
                      color: Color(0xff414141),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),



            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Color(0xff3f1602)

                      ),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFFDFBEF),
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            // package: 'flutter_credit_card',
                          ),
                        ),
                      ),
                      onPressed: (){
                        // Obtener los valores ingresados por el usuario en los campos de correo electrónico y contraseña
                        String phoneNumber = emailController.text;
                        String type = passwordController.text;

                        // Llamar al método para verificar las credenciales del usuario
                        loginUser(phoneNumber, type);                      },

                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 250,
              child: Image(
                  image: AssetImage("assets/img/logo.png")
              ),
            )






          ],
        ),
      ),
      //bottom bar
    );
  }


  Future<void> loginUser(String phoneNumber, String type) async {
    try {
      final userProfile = await service.getUserProfileByCredentials(phoneNumber, type);

      if (userProfile != null) {
        // Credenciales válidas, redirige al usuario a la pantalla de éxito
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView(userId: userProfile.id)),
        );
      } else {
        // Credenciales inválidas, muestra un mensaje de error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error de autenticación'),
            content: Text('Las credenciales ingresadas no son válidas.'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Ocurrió un error al obtener el perfil de usuario, muestra un mensaje de error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error de conexión'),
          content: Text('No se pudo obtener el perfil de usuario.'),
          actions: [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }





}

