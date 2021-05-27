import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class AppData extends ChangeNotifier {
  String add1;
  String add2;
  LatLng lastLngPosition;
  var coordinates;
  double addressLatitude;
  double addressLongitude;
  final Set<Polyline> polyline = {};
  Set<Polyline> lines = {};

  Future<void> locationPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lastLngPosition = LatLng(position.latitude, position.longitude);
    double addressLatitude = lastLngPosition.latitude;
    double addressLongitude = lastLngPosition.longitude;
    coordinates = new Coordinates(addressLatitude, addressLongitude);
    print("Your LatLng is ...........$coordinates");
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    add1 = addresses.first.featureName;
    add2 = addresses.first.addressLine;
    notifyListeners();
  }

  // void obtainPlaceDirection(
  //     LatLng initialposition, LatLng finalposition) async {
  //   String directionurl =
  //       "https://maps.googleapis.com/maps/api/directions/json?origin=${initialposition.latitude},${initialposition.longitude}Toronto&destination=${finalposition.latitude},${finalposition.longitude}&key=$mapKey";
  //   var res = await RequestAssistant.getRequest(directionurl);

  //   if (res == "failed") {
  //     return;
  //   }

  //   DirectionDetails directionDetails = DirectionDetails();

  //   directionDetails.encodedPoint =
  //       res["routes"][0]["overview_polyline"]["points"];

  //   directionDetails.encodedPoint = res["routes"][0]["AS"];
  // }

polyLine(){
        lines.add(
      Polyline(
        points: [LatLng(addressLatitude,addressLongitude), LatLng(24.4076626,88.98165699999998)],
        startCap: Cap.buttCap,
        endCap: Cap.buttCap,
        color: Colors.black,
        polylineId: PolylineId("line_one"),
      ),
    );
  }

}
