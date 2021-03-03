import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frieden/AllScreens/MainScreen.dart';
import 'package:frieden/AllScreens/loginScreen.dart';
import 'package:frieden/AllWidgets/ProgressDialogue.dart';
import 'package:frieden/main.dart';

class registerScreen extends StatelessWidget {
  static const String idScreen ="register";
  TextEditingController nameTextEditingController =TextEditingController();
  TextEditingController phoneTextEditingController =TextEditingController();
  TextEditingController emailTextEditingController =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left:2.0),

                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image(


                      image: AssetImage("images/frieden logo originalwhite-01.png"),
                      width: 380.0,
                      height: 190.0,
                      alignment: Alignment.center,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.0,),
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Text(
                  "Register as a partner",

                  style: TextStyle(fontSize: 28.0, fontFamily: "Brand Bold", color: Colors.white),
                  textAlign: TextAlign.center,

                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      TextFormField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,


                        decoration: InputDecoration(
                          labelText: "Name",
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
                      ),
                      SizedBox(height: 1.0,),
                      TextFormField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,


                        decoration: InputDecoration(
                          labelText: "Phone",
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
                      ),

                      SizedBox(height: 1.0,),
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
                              "Create Account",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0),
                        ),
                        onPressed: (){
                          if(nameTextEditingController.text.length < 4){
                              displayToastMessage("Name must be atleast 4 Characters.", context);
                          }
                           else if(!emailTextEditingController.text.contains("@"))
                          {
                            displayToastMessage("This is not a valid email.", context);
                          }
                          else if(phoneTextEditingController.text.length !=  10)
                          {
                          displayToastMessage("This is not a valid phone number.", context);
                          }
                          else if(phoneTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Phone number is mandatory.", context);
                          }
                          else if(passwordTextEditingController.text.length <6)
                          {
                          displayToastMessage("Password mustbe atleast 6 characters", context);
                          }
                          else if(nameTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Name is mandatory.", context);
                          }
                          else if(emailTextEditingController.text.isEmpty)
                          {
                          displayToastMessage("Email is mandatory.", context);
                          }
                          else if(passwordTextEditingController.text.isEmpty)
                          {
                            displayToastMessage("Password is mandatory", context);
                          }
                          else{
                            registerNewUser(context);
                          }







                        },
                      ),

                      FlatButton(
                        padding: EdgeInsets.only(top: 25.0),
                        onPressed: (){
                          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                        },

                        child: Text(
                          "Already have an Account? Login Here.",
                          style: TextStyle(color: Colors.white),
                        ),

                      ),



                    ],
                  )
              ),



            ],
          ),

        ));
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
    showDialog
      (context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, please wait... ",);
        }

    );
      final User firebaseUser = (await _firebaseAuth.
      createUserWithEmailAndPassword(
          email: emailTextEditingController.text, password: passwordTextEditingController.text
      ).catchError((errMsg){
          displayToastMessage("Error "+errMsg.toString(), context);
      })).user;

      if(firebaseUser != null)
      {
          userRef.child(firebaseUser.uid);
          Map userDataMap =
          {
            "name":nameTextEditingController.text.trim(),
            "email":emailTextEditingController.text.trim(),
            "phone":phoneTextEditingController.text.trim(),
          };
          userRef.child(firebaseUser.uid).set(userDataMap);
          displayToastMessage("Congratulation, your account has been created.", context);
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          //if you want you can update firebase auth data like( add name email etc. in firebase user)//
      }
      else
        {
          displayToastMessage("New user account has not been created", context);
      }
  }

}
displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}