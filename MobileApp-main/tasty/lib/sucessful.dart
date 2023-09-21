import 'package:flutter/material.dart';
import 'package:tasty/vista1.dart';


class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({Key? key}) : super(key: key);

  @override
  _SuccessfulPageState createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFEFBC3D),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Color(0xff3f1602),
              ),
              onPressed:(){})
        ],

      ),



      body: Center(
        child: Column(
          children:[
            SizedBox(
              height: 105,
            ),
            Image(
            image: AssetImage('assets/img/successful.png'), // <-- SEE HERE
          ),
            SizedBox(
              height: 65,
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
                  'Continue',
                  style: TextStyle(
                    color: Color(0xFFFDFBEF),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
              },)]
        ),
      ),

    );
  }


}