import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frieden/AllScreens/MainScreen.dart';
import 'package:frieden/AllScreens/Reset.dart';
import 'package:frieden/AllScreens/registerScreen.dart';
import 'package:frieden/AllWidgets/ProgressDialogue.dart';
import 'package:frieden/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen ="login";
  TextEditingController emailTextEditingController =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:0.0),
            child: SizedBox(height: 0.0,),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),

            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Image(


                    image: AssetImage("images/frieden logo originalwhite-01.png"),
                  width: 360.0,
                  height:220.0,
                  alignment: Alignment.center,

                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                  "Login as a partner",

                   style: TextStyle(fontSize: 28.0, fontFamily: "Brand Bold", color: Colors.white),
                   textAlign: TextAlign.center,

              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom:0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:0.0),
                    child: SizedBox(height: 1.0,),
                  ),
                  TextFormField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,


                    decoration: InputDecoration(
                      labelText: "Email",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14.0,color: Colors.white
                      ),

                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),

                    ),


                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                    onChanged: (value){
                      value=email;
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    controller: passwordTextEditingController,

                    obscureText: true,

                    decoration: InputDecoration(
                      labelText: "Password",
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
                  SizedBox(height: 40.0,),
                  RaisedButton(
                    color: Colors.amber,
                    textColor: Colors.black,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: (){
                      if(!emailTextEditingController.text.contains("@"))
                      {
                        displayToastMessage("This is not a valid email.", context);
                      }
                      else if(passwordTextEditingController.text.isEmpty)
                      {
                        displayToastMessage("Password is mandatory", context);
                      }
                      else
                        {
                        loginAndAuthentUser(context);
                      }

                    },
                  ),

                  FlatButton(
                    padding: EdgeInsets.only(top: 25.0),
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, registerScreen.idScreen, (route) => false);
                    },

                    child: Text(
                        "Do not have an Account? Register Here.",
                        style: TextStyle(color: Colors.white),
                    ),

                  ),
                  FlatButton(
                    padding: EdgeInsets.only(top: 12.0),
                    onPressed: (){
                     Navigator.pushNamedAndRemoveUntil(context, ResetScreen.idScreen, (route) => false);

                    },

                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),

                  ),



                ],
               ),
            )
          ),
          SizedBox(height: 0.0,),



        ],
      ),

    ));
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthentUser(BuildContext context) async{

    showDialog
      (context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
       return ProgressDialog(message: "Authenticating, please wait... ",);
      }

    );
    final User firebaseUser = (await _firebaseAuth.
    signInWithEmailAndPassword(
        email: emailTextEditingController.text, password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error "+errMsg.toString(), context);
    })).user;
    if(firebaseUser != null)
    {

      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value != null){
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged in now.", context);
        }
        else{
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user.Create new account now", context);
        }
      });


    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error Occured, can not be Logged in.", context);
    }
  }
}
