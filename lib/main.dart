import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frieden/AllScreens/MainScreen.dart';
import 'package:frieden/AllScreens/Reset%20Screen.dart';
import 'package:frieden/AllScreens/loginScreen.dart';
import 'package:frieden/AllScreens/registerScreen.dart';
import 'package:frieden/Payment%20Option.dart';
import 'package:frieden/appData.dart';
import 'package:frieden/cyclebooking.dart';
import 'package:frieden/finalpayment.dart';
import 'package:provider/provider.dart';

import 'package:frieden/cyclebooking.dart';

import 'AllScreens/Reset.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("Users");


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Frieden Rider',
        theme: ThemeData(
          fontFamily: "Brand Bold",

          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainScreen.idScreen,
        routes: {
          registerScreen.idScreen: (context) => registerScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          CycleBooking.idScreen: (context) => CycleBooking(),
          paymentOption.idScreen: (context) => paymentOption(),
          finalPayment.idScreen: (context) => finalPayment(),
          ResetScreen.idScreen: (context) => ResetScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



