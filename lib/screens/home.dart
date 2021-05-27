import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/helper/convertAddress.dart';
import 'package:uber_clone/navbar/navabar.dart';
import 'package:uber_clone/utils/Divider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GoogleMapController mapController;
  final Set<Polyline> polyline = {};
  double rideDetailsContainer = 0;
  double searchContainerHeight = 300;
  double bottomPaddingOfMap = 0;
  double requestRideContainerHeight = 0;

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: 'Horizon',
  );

  TextEditingController destinationController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  double bottomPadding = 0;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.407657, 88.981600),
    zoom: 10.4746,
  );
  Location _location = Location();
  Set<Polyline> lines = {};
  bool drawerOpen = true;

  void displayRequestRideContainer() {
    setState(() {
      requestRideContainerHeight = 250.0;
      rideDetailsContainer = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });
  }

  void displayRideDetailsContainer() async {
    await AppData().lastLngPosition;
    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainer = 240;
      bottomPaddingOfMap = 300.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppData _appData = Provider.of<AppData>(context);
    return Scaffold(
      key: scaffoldkey,
      drawer: NavigationBar(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _location.onLocationChanged.listen((l) {
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(l.latitude, l.longitude), zoom: 15)));
              });
              _appData.locationPosition();
              setState(() {
                bottomPadding = 320.0;
              });
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
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    radius: 20.0,
                  )),
            ),
          ),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: AnimatedSize(
                vsync: this,
                curve: Curves.bounceIn,
                duration: new Duration(microseconds: 160),
                child: Container(
                  height: searchContainerHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(7.0, 7.0),
                            blurRadius: 16,
                            spreadRadius: 0.5)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "HI There",
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          "Where to?",
                          style: TextStyle(
                              fontSize: 15.0, fontFamily: "Brand Bold"),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            displayRideDetailsContainer();
                          },
                          // onTap: () async {
                          //   var res = await Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SearchScreen()));
                          //   if (res == "obtainDirection") {
                          //     displayRideDetailsContainer();
                          //   }
                          // },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(7.0, 7.0),
                                      blurRadius: 9.0,
                                      spreadRadius: 0.5)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.blueAccent),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Search Drop Off")
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_appData.add2}"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Your Living Home Address",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12.0),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DeviderWidget(),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_appData.add1}"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "Your Office Address",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12.0),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(microseconds: 160),
              child: Container(
                height: rideDetailsContainer,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/car.png",
                                height: 70.0,
                                width: 80.0,
                              ),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Car",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    "10km",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.moneyCheckAlt,
                                size: 18, color: Colors.black),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text('Cash'),
                            SizedBox(
                              width: 6.0,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            displayRequestRideContainer();
                          },
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Icon(
                                  FontAwesomeIcons.taxi,
                                  color: Colors.white,
                                  size: 15.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              height: requestRideContainerHeight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Please wait......',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'Finding Your Ride',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                        ],
                        isRepeatingAnimation: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(width: 2.0, color: Colors.grey[300]),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Cancle Ride',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
