import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/Assistant/requestAssistent.dart';
import 'package:uber_clone/Models/placePrediction.dart';
import 'package:uber_clone/configMap.dart';
import 'package:uber_clone/helper/convertAddress.dart';
import 'package:uber_clone/utils/Divider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickuptextEditingController = TextEditingController();
  TextEditingController dropofftextEditingController;
  List<PlacePrediction> placepredictionList = [];
  @override
  Widget build(BuildContext context) {
    AppData _appData = Provider.of<AppData>(context);
    String placeAddress = _appData.add2;
    print("Your PickUp Address" + placeAddress);
    pickuptextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text(
                          'The Drop off',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            controller: pickuptextEditingController,
                            decoration: InputDecoration(
                              hintText: "PickUp Location",
                              fillColor: Colors.grey,
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, top: 8, bottom: 8),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.description_rounded),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextField(
                            onChanged: (val) {
                              findPlaces(val);
                            },
                            // controller: _appData.getsomepoints(dropofftextEditingController),
                            decoration: InputDecoration(
                              hintText: "Where to go",
                              fillColor: Colors.grey[400],
                              filled: true,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(left: 11, top: 8, bottom: 8),
                            ),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          (placepredictionList.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        placePrediction: placepredictionList[index],
                      );
                    },
                    separatorBuilder: (BuildContext contex, int index) =>
                        DeviderWidget(),
                    itemCount: placepredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ))
              : Container()
        ],
      ),
    );
  }

  void findPlaces(String placename) async {
    if (placename.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$mapKey&sessiontoken=1234567890&components=country:bd";
      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }
      print("Your baddress..............$res");
      if (res["status"] == "OK") {
        var predictions = res["predictions"];
        var placesList = (predictions as List)
            .map((e) => PlacePrediction.fromJson(e))
            .toList();
        setState(() {
          placepredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePrediction placePrediction;
  PredictionTile({
    Key key,
    this.placePrediction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Icon(Icons.add_location),
              SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(placePrediction.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 3,
                    ),
                    Text(placePrediction.second_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
