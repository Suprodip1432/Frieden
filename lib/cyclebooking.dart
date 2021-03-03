import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: camel_case_types
class CycleBooking extends StatelessWidget {
  static const String idScreen ="cyclebooking";
  @override
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
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: SizedBox(height: 1.0,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:0.0, left: 15.0),
                child: Text(
                  "Select a payment method",

                  style: TextStyle(fontSize: 28.0, fontFamily: "Brand Bold", color: Colors.blueAccent),
                  textAlign: TextAlign.center,

                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: SizedBox(height: 10.0,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: [

                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(FontAwesomeIcons.moneyCheckAlt, size: 30.0, color: Colors.black54,),
                        ),
                    SizedBox(width: 25.0,),
                    Text("Cash", style: TextStyle(fontSize: 50.0),),
                    SizedBox(width: 6.0,),
                    Icon(Icons.keyboard_arrow_down, size: 30.0, color: Colors.black54,),




                  ],

                ),
              ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 30.0),
            child: ButtonTheme(
              minWidth: 300.0,
            height: 60,
            child: RaisedButton
              (
              color: Colors.amber,
              textColor: Colors.black,

              child: Text(
                "Request",
                style: TextStyle(fontSize: 25.0, fontFamily: "Brand Bold"),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(24.0),
              ),
              onPressed: (){

              },


            ),
            ),
          ),
            ],





          ),
        ),



      ),
    );

  }

}
