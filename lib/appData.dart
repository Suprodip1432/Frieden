import 'package:flutter/cupertino.dart';
import 'package:frieden/Models/address.dart';
class AppData extends ChangeNotifier
{

  Address pickUpLocation;

  void PickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

}