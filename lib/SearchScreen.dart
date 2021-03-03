import 'package:flutter/material.dart';
import 'package:frieden/appData.dart';
import 'package:frieden/config%20Maps.dart';
import 'package:provider/provider.dart';

import 'Assistants/requestAssistants.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickupTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();






  @override
  Widget build(BuildContext context) {

    String placeAddress = Provider.of<AppData>(context).pickUpLocation?? "";
    pickupTextEditingController.text = placeAddress;


    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:  [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),

                )
              ]
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0,top: 50.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Stack(
                    children: [
                      GestureDetector
                        (
                        onTap:()
                {
                         Navigator.pop(context);
            },

                          child: Icon(Icons.arrow_back)
                      ),
                      Center(
                        child: Text("Set Drop Off", style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Image.asset("images/pickicon.png",height: 16.0,width: 16.0,),

                      SizedBox(width: 18.0,),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),


                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                controller: pickupTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "PickUp Location",
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(top: 8.0, left: 11.0, bottom: 8.0),
                                )
                              ),

                            )
                          ),



                      ),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Image.asset("images/desticon.png",height: 16.0,width: 16.0,),

                      SizedBox(width: 18.0,),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5.0),


                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (val)
                                    {
                                      findPlace(val);

                                      },
                                controller: dropOffTextEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Where to?",
                                    fillColor: Colors.grey,
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(top: 8.0, left: 11.0, bottom: 8.0),
                                  )
                              ),

                            )
                        ),



                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void findPlace(String placeName) async
  {
    if(placeName.length > 1){
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$Mapley&sessiontoken=1234567890&components=country.IN";
      var res = await RequestAssistant.getRequest(autoCompleteUrl) ;

      if(res == "failed")
      {
        return;
      }
      print("Places predictions Responses :: ");
      print(res);


  }


  }
}
