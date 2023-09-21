import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:tasty/sucessful.dart';
import 'package:rounded_background_text/rounded_background_text.dart';


class CreditCardPage extends StatefulWidget {
  const CreditCardPage({Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate= '';
  String cardHolderName = '';
  String cvvCode= '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(

          children: [
            SizedBox(
              height: 35,
            ),
            RoundedBackgroundText(
              'Payment',
              style: const TextStyle(color:Color(0xffefbc3d),fontSize: 40,fontWeight: FontWeight.bold),
              backgroundColor: Color(0xfffdfbef),

            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      CreditCardForm(cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Color(0xff3f1602),
                        formKey: formKey,
                        cardNumberDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'xxxx xxxx xxxx xxxx'
                        ),
                        expiryDateDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expired Date',
                            hintText: 'xx/xx'
                        ),
                        cvvCodeDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'xxx'
                        ),
                        cardHolderDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                      ),
                      SizedBox(
                        height: 140,
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
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SuccessfulPage()),);
                        },)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel){
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}