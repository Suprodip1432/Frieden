import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frieden/AllScreens/registerScreen.dart';
import 'package:frieden/Payment%20Option.dart';
import 'package:frieden/config%20Maps.dart';
import 'package:frieden/finalpayment.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:frieden/cyclebooking.dart';
import 'package:frieden/assistantMethods.dart';
import 'package:provider/provider.dart';
import 'package:frieden/allUsers.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "MainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();


  }


class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double requestRideContainerHeight = 0;
  double rideDetailsContainerHeight = 0;
  double rideDetailsContainerHeight2 = 0;
  double searchContainerHeight = 0;
  var key = "";
  bool drawerOpen = true;
  DatabaseReference rideRequestRef; //this is refference
  var pickup = Position();
  double ridedetailscontainer =0;
  double ridedetailscontainer2 =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AssistantMethod.getCurrentOnlineUserInfo();
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 300;
      rideDetailsContainerHeight = 0;
      requestRideContainerHeight = 0;
      bottomPaddingOfMap = 300;
      rideDetailsContainerHeight=0;
      rideDetailsContainerHeight2=0;
    });
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void displayRequestRideContainer() async{
    _saveRideRequest(); //
    setState(() {
      requestRideContainerHeight = 350.0;

      bottomPaddingOfMap = 300.0;
      drawerOpen = true;
    });
  }
  void rideDetailsContainer()async
  {
    setState(() {
      rideDetailsContainerHeight = 350.0;
      bottomPaddingOfMap = 300.0;

    });
  }
  void rideDetailsContainer2()async
  {
    setState(() {
      rideDetailsContainerHeight2 = 350.0;
      bottomPaddingOfMap = 300.0;

    });
  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                child: Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/user_icon.png",
                          height: 65.0,
                          width: 65.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Profile Name",
                                style: TextStyle(
                                    fontSize: 16.0, fontFamily: "Brand Bold"),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text("Visit Profile"),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: SizedBox(
                  height: 6.0,
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                  displayToastMessage("You are logged out now.", context);
                },
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 350.0;
              });

              locatePosition();
            },
          ),
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldkey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0,left: 40.0,right: 40.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  ),
                ],
              ),

                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.blueAccent,),
                      SizedBox(width: 10.0),
                      Text("Search Drop Off")


                    ],
                  ),
                ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: 350.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text(
                        "Hi there,",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 6.0),
                      Text("Book Now!! What you need",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Brand Bold",
                              color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 130.0),
                            Image.asset(
                              "images/cyclepng-01.png",
                              height: 125.0,
                              width: 125.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 62.0),
                              child: SizedBox(height: 130.0),
                            ),
                            Image.asset(
                              "images/walking partnerpng-01.png",
                              height: 125.0,
                              width: 125.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 0.0),
                            Text(
                              "Sharing Partner",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 39.0),
                              child: SizedBox(height: 5.0),
                            ),

                            Text(
                              "Walking Partner",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: "Brand Bold"),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 6.0, left: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RaisedButton(
                              color: Colors.blueAccent,
                              textColor: Colors.black,
                              child: Text(
                                "Book One",
                                style: TextStyle(
                                    fontSize: 18.0, fontFamily: "Brand Bold"),
                              ),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(24.0),
                              ),
                              onPressed: () {
                               rideDetailsContainer();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: RaisedButton(
                                color: Colors.blueAccent,
                                textColor: Colors.black,
                                child: Text(
                                  "Book One",
                                  style: TextStyle(
                                      fontSize: 18.0, fontFamily: "Brand Bold"),
                                ),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0),
                                ),
                                onPressed: () {
                                  rideDetailsContainer2();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),



          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,


              child: AnimatedSize(
                vsync: this,
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                  height: rideDetailsContainerHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),

                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:50.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.amber,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Image.asset("images/cyclepng-01.png", height: 70.0, width: 80.0,),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sharing Partner", style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold"),),
                                    Text("₹30(30min)", style: TextStyle(fontSize: 16.0, color: Colors.grey[50]),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0,),

                        Padding(
                        padding: EdgeInsets.only(top: 40.0,left: 20.0),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0,color: Colors.black54),
                              SizedBox(width: 16.0,),
                              Text("Cash"),
                              SizedBox(width:6.0),
                              Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),


                            ],
                          ),
                        ),

                       Padding(
                         padding: const EdgeInsets.only(top: 60.0,left: 15.0,right: 15.0),
                         child: RaisedButton(
                              color: Theme.of(context).accentColor,
                           onPressed: () {
                                displayRequestRideContainer();
                           },
                           child: Padding(
                             padding: EdgeInsets.all(17.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),

                               ],
                             ),
                           ),
                          ),
                       )

                      ],
                    ),
                  ),


                ),
              ),),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,


              child: AnimatedSize(
                vsync: this,
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                  height: rideDetailsContainerHeight2,
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),

                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:50.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.amber,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Image.asset("images/walking partnerpng-01.png", height: 70.0, width: 80.0,),
                                SizedBox(width: 16.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Walking Partner", style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold"),),
                                    Text("₹25", style: TextStyle(fontSize: 16.0, color: Colors.grey[50]),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0,),

                        Padding(
                          padding: EdgeInsets.only(top: 40.0,left: 20.0),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0,color: Colors.black54),
                              SizedBox(width: 16.0,),
                              Text("Cash"),
                              SizedBox(width:6.0),
                              Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),


                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 60.0,left: 15.0,right: 15.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              displayRequestRideContainer();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),


                ),
              ),),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: requestRideContainerHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black54,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ColorizeAnimatedTextKit(
                            onTap: () {
                              print("Tap Event");
                            },
                            text: [
                              "Requesting.....",
                              "Please wait....",
                              "Finding partner",
                            ],
                            textStyle:
                            TextStyle(fontSize: 65.0, fontFamily: "Signatra"),
                            colors: [
                              Colors.greenAccent,
                              Colors.purple,
                              Colors.pink,
                              Colors.blue,
                              Colors.yellow,
                              Colors.red,
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 22.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            cancelRideRequest();
                            resetApp();
                          },
                          child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26.0),
                              border:
                              Border.all(width: 2.0, color: Colors.grey[300]),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 26.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Cancel Ride",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Position>('currentPosition', currentPosition));
  }

  void _saveRideRequest() async {
    DatabaseReference rideRequestRef =
        FirebaseDatabase().reference().child("Ride Requests");
//value is null.how can I fix it? : where you setv  value
    Map pickUpLocMap = {
      "latitude": pickup.latitude.toString(),
      "longitude": pickup.longitude.toString(),

    };

    Map rideInfoMap =
        {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": currentPosition,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo.name,
      "rider_phone": userCurrentInfo.phone,



      "pickup_address": pickup.toString(),
    };
    Map rideInfoMap2 =
    {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": currentPosition.toString(),
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo.name,
      "rider_phone": userCurrentInfo.phone,



      "pickup_address": pickup.toString(),
    };


    key = rideRequestRef
        .push()
        .key; // what is the error sir I can't understand. (this error is similar to multiDex)

    rideRequestRef
        .child(key)
        .set(rideInfoMap, )
        .then((value) => {print("uploaded")}) //test now
        .catchError((onError) {
      print("upload failed: " +
          onError
              .toString()); // sir it was shpwing build failed.I am testing again.
    });

  }

  void cancelRideRequest() {
    DatabaseReference rideRequestRef =
        FirebaseDatabase().reference().child("Ride Requests");
    rideRequestRef.child(key).remove();
  }
}
