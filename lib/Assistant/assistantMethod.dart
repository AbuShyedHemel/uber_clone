// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:uber_clone/Assistant/requestAssistent.dart';
// import 'package:uber_clone/DataHandaller/appData.dart';
// import 'package:uber_clone/Models/address.dart';
// import 'package:provider/provider.dart';

// class AssistantMethods {
//   Future<String> searchCoordinateAddress(Position position, context) async {
//     String placeAddress = "";
//     String st1, st2, st3, st4;
//     String url =
//         "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyAjlECp--ZWD1KLMrzZrBWKrP8DcxOgeOg";

//     var response = await RequestAssistant.getRequest(url);
//     print(response);

//     if (response != 'failed') {
//       // placeAddress = await response["results"][0]["formatted_address"];
//       var length = response["results"].length;
//       print("NUMBERS OF RESULTS:$length");
//       if (length > 0) {
//         if (response["results"][0]["address_components"] > 0) {
//           st1 = response["results"][2]["address_components"][3]["long_name"];
//           st2 = response["results"][0]["address_components"][4]["long_name"];
//           st3 = response["results"][0]["address_components"][5]["long_name"];
//           st4 = response["results"][0]["address_components"][6]["long_name"];
//           placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;
//         }
//         print("Failed");
//       } else {
//         print("SOmething Wrong");
//       }

//       Address userPickupAddress = new Address();
//       userPickupAddress.longtidue = position.longitude as String;
//       userPickupAddress.latitude = position.latitude as String;
//       userPickupAddress.placeName = placeAddress;

//       Provider.of<AppData>(context, listen: false)
//           .updatePickupLocationAddress(userPickupAddress);
//     }
//     return placeAddress;
//   }
//   static import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:uber_clone/configMap.dart';

// void getCurrentOnlineInfo() async
//   {
//     firebaseUser = await FirebaseAuth.instance.currentUser;
//     String user = firebaseUser.uid;
//     DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);

//     reference.once().then(DataSnapshot dataSnapshot){
//       if (dataSnapshot.value != null) {
//         Users users = Users.fromSnapshot(dataSnapshot);
//       }
//     };
//   }
// }
