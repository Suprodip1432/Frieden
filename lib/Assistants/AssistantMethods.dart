

import 'package:frieden/Assistants/requestAssistants.dart';
import 'package:frieden/Models/address.dart';
import 'package:frieden/appData.dart';
import 'package:frieden/config%20Maps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position, context) async
  {

    String placeAddress = "";
    String st1,st2,st3,st4;
    String url ="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$Mapley";

    var response = await RequestAssistant.getRequest(url);

    if(response != "Failed.")
      {
        st1 = response["results"]  [0]["address_components"][3]["long_name"];
        st2 = response["results"][0]["address_components"][4]["long_name"];
        st3 = response["results"][0]["address_components"][5]["long_name"];
        st4 = response["results"][0]["address_components"][6]["long_name"];
        placeAddress = st1 + ", " + st2 + ", " + st3 + ", "+ st4 ;


        Address userPickUpAddress = new Address();
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;
        userPickUpAddress.placeName = placeAddress;

        Provider.of<AppData>(context, listen: false).PickUpLocationAddress(userPickUpAddress);

      }
    return placeAddress;


  }
}