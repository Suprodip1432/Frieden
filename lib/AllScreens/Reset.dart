import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frieden/AllScreens/MainScreen.dart';
import 'package:frieden/AllScreens/registerScreen.dart';
class ResetScreen extends StatelessWidget {
  static const String idScreen ="reset";
  TextEditingController emailTextEditingController =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  String email;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: SizedBox(height: 0.0,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),

              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Image(


                    image: AssetImage(
                        "images/frieden logo originalwhite-01.png"),
                    width: 360.0,
                    height: 220.0,
                    alignment: Alignment.center,

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  "Reset Password",

                  style: TextStyle(fontSize: 28.0,
                      fontFamily: "Brand Bold",
                      color: Colors.white),
                  textAlign: TextAlign.center,

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: SizedBox(height: 1.0,),
                    ),
                    TextFormField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        value = email;

                      },


                      decoration: InputDecoration(
                        labelText: "Email",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            fontSize: 14.0, color: Colors.white
                        ),

                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),

                      ),


                      style: TextStyle(fontSize: 14.0, color: Colors.white),

                    ),
                    FlatButton(
                      padding: EdgeInsets.only(top: 25.0),
                      onPressed: () {
                        if(email!=null){

                          _firebaseAuth.sendPasswordResetEmail(email: email);
                          Navigator.of(context).pop();
                          displayToastMessage("Sent", context);
                        }
                        else {
                          displayToastMessage("Enter your email", context);
                        }
                      },
                      child: Text(
                        "Send Request",
                        style: TextStyle(color: Colors.white),
                      ),


                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}