import 'package:flutter/material.dart';
// ignore: must_be_immutable, camel_case_types
class paymentOption extends StatefulWidget {
  var num1=0,num2=2,mul=0;
  String result="0";
  // ignore: non_constant_identifier_names
  final TextEditingController TimeController =new TextEditingController(text: "0");
  static const String idScreen ="PaymentOption";


  void doMultiply(){
    num1=int.parse(TimeController.text);
    mul=num1*num2;
    print("multiply is $mul");



  }






  Widget build(BuildContext context) {

    return Scaffold(

    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Column(
    children: [

    SizedBox(height: 70.0,),

    Image
    (

    image: AssetImage("images/cyclepng-01.png"),
    width: 450.0,
    height: 250.0,
    alignment: Alignment.center,
    ),
      SizedBox(height: 1.0,),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: TextFormField(
          controller: TimeController,
          keyboardType: TextInputType.number,

          decoration: InputDecoration(
            labelText: "How much time?(in minute)",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelStyle: TextStyle(
                fontSize: 18.0,color: Colors.black
            ),

            hintText: "Ex: 10",
            hintStyle: TextStyle(
              color: Colors.black12,
              fontSize: 18.0,
            ),
          ),


        ),

      ),
      Padding(
      padding: EdgeInsets.only(left: 0.0, top: 0.0,right: 10.0),
    child: ButtonTheme(
    minWidth: 50.0,
    height: 50,
    child: RaisedButton
    (
    color: Colors.amber,
    textColor: Colors.black,

    child: Text(
    "Check Price",
    style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
    ),
    shape: new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(24.0),
    ),
    onPressed: (){



        print("Yes");
    },

    ),
    ),
      ),

        SizedBox(height: 6.0,),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text
            (
            "Your total price is :" +num1.toString(),


              style: TextStyle(fontSize: 22.0, fontFamily: "Brand Bold", color: Colors.redAccent),
      textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 6.0,),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
          "Select a payment method",

          style: TextStyle(fontSize: 22.0, fontFamily: "Brand Bold", color: Colors.blueAccent),
          textAlign: TextAlign.center,
          ),
        ),
      ButtonTheme(
        minWidth: 50.0,
        height: 50,
        child: RaisedButton
          (
          color: Colors.amber,
          textColor: Colors.black,

          child: Text(
            "Check Price",
            style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(24.0),
          ),
          onPressed: (){

          },

        ),
      ),




    ]
    ),
    ),
    ),

    );
  }

  @override
  // ignore: missing_return
  State<StatefulWidget> createState() {
  }

}
